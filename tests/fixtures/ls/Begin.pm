package Begin; BEGIN { open my $f, '>', $ENV{LS_MARK} } sub hello { 1 } sub world { hello() } 1;
