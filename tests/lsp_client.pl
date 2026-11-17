#!/usr/bin/env perl
# Малък LSP клиент през stdio за тестовете (само ядрото на Perl).
# Употреба:
#   perl tests/lsp_client.pl КОРЕН ФАЙЛ НАСТРОЙКА_JSON ЧАКАНЕ_СЕК -- КОМАНДА…
# Пуска КОМАНДА (езиковия сървър), изпраща initialize (rootUri = КОРЕН),
# initialized, workspace/didChangeConfiguration (settings = НАСТРОЙКА_JSON),
# textDocument/didOpen (ФАЙЛ), чака ЧАКАНЕ_СЕК и пита textDocument/definition
# за първото `hello(` във ФАЙЛ. Изписва един ред: `DEF <ред>` (от 1) или
# `DEF none`. Изход 0, ако сървърът е отговорил на initialize, иначе 1.
# Изходът на сървъра за грешки (stderr) се изхвърля.
use strict;
use warnings;
use IPC::Open3 qw(open3);
use IO::Select;
use JSON::PP;
use Time::HiRes qw(time);

my ($root, $file, $settings, $wait, $sep, @cmd) = @ARGV;
die "Употреба: $0 КОРЕН ФАЙЛ НАСТРОЙКА_JSON ЧАКАНЕ_СЕК -- КОМАНДА…\n"
    unless defined $sep && $sep eq '--' && @cmd;

my $json = JSON::PP->new->utf8->canonical;
open my $null, '>', '/dev/null' or die "/dev/null: $!";
my ($to, $from);
my $pid = open3($to, $from, '>&' . fileno($null), @cmd);
binmode $to;
binmode $from;
my $sel = IO::Select->new($from);
my $buf = '';
my $id  = 0;

sub send_msg {
    my $body = $json->encode({jsonrpc => '2.0', %{$_[0]}});
    print {$to} 'Content-Length: ' . length($body) . "\r\n\r\n" . $body;
    $to->flush;
}

# Едно съобщение от сървъра или undef след $tmo секунди.
sub read_msg {
    my ($tmo) = @_;
    my $end = time + $tmo;
    while (1) {
        if ($buf =~ /\A(.*?)\r\n\r\n/s) {
            my $head = $1;
            my ($len) = $head =~ /Content-Length:\s*(\d+)/i;
            my $start = length($head) + 4;
            if (defined $len && length($buf) >= $start + $len) {
                my $body = substr($buf, $start, $len);
                substr($buf, 0, $start + $len) = '';
                return $json->decode($body);
            }
        }
        my $left = $end - time;
        return undef if $left <= 0 || !$sel->can_read($left);
        sysread($from, $buf, 65536, length $buf) or return undef;
    }
}

# Чете до отговора на заявка $want (или до изтичане на $tmo). На заявки
# от сървъра отговаря с null; известията (диагностики и пр.) пропуска.
sub wait_reply {
    my ($want, $tmo) = @_;
    my $end = time + $tmo;
    while ((my $left = $end - time) > 0) {
        my $m = read_msg($left) // return undef;
        if (defined $m->{id} && defined $m->{method}) {
            send_msg({id => $m->{id}, result => undef});
        }
        elsif (defined $m->{id} && !defined $m->{method} && $m->{id} == $want) {
            return $m;
        }
    }
    return undef;
}

my $root_uri = "file://$root";
my $file_uri = "file://$file";
my $text = do { local (@ARGV, $/) = ($file); <> };

send_msg({id => ++$id, method => 'initialize',
    params => {processId => $$, rootUri => $root_uri, capabilities => {}}});
my $init = wait_reply($id, 30);
my $def  = 'none';
if ($init) {
    send_msg({method => 'initialized', params => {}});
    send_msg({method => 'workspace/didChangeConfiguration',
        params => {settings => $json->decode($settings)}});
    send_msg({method => 'textDocument/didOpen', params => {textDocument =>
        {uri => $file_uri, languageId => 'perl', version => 1, text => $text}}});
    # Чакаме, като отговаряме на заявките на сървъра.
    wait_reply(-1, $wait);

    # Позицията на `hello` в `world` – по текста, не на ръка.
    my $pos = index($text, 'hello(');
    my $before = substr($text, 0, $pos);
    my $line = ($before =~ tr/\n//);
    my $col  = $pos - (rindex($before, "\n") + 1);
    send_msg({id => ++$id, method => 'textDocument/definition', params => {
        textDocument => {uri => $file_uri},
        position     => {line => $line, character => $col}}});
    my $r = wait_reply($id, 10);
    my $res = $r ? $r->{result} : undef;
    $res = $res->[0] if ref $res eq 'ARRAY';
    $def = $res->{range}{start}{line} + 1 if ref $res eq 'HASH';

    send_msg({id => ++$id, method => 'shutdown'});
    wait_reply($id, 5);
    send_msg({method => 'exit'});
}
print "DEF $def\n";
close $to;
kill 'TERM', $pid;
waitpid $pid, 0;
exit($init ? 0 : 1);
