" Vim keymap file for Old Bulgarian, known as Old Church Slavonic, "phonetic"
" layout. It is intended to be used in utf-8 encoded txt files. This file
" itself is in utf-8. It is based on the bulgarian-phonetic.vim, created by
" Boyko Bantchev. I wanted to be able to write using the so called “Иванчовски
" правопис”, but after discovering the possibilities, I decided to add all the
" missing letters from the old alphabet.

" Maintainer:   Krasimir Berov <berov@cpan.org>
" URI:
" Last Changed: 2018 February 18

" This keymap corresponds to what is called "phonetic layout" in Bulgaria:
" Cyrillic letters tend to be mapped to their Latin homophones wherever
" there are ones. Most keys corresponding to punctuation characters are
" left unmapped, so they retain their usual (QWERTY) meanings when typing
" Cyrillic.
"
" In addition to the contemporary Bulgarian alphabet, the keymap makes
" accessible the following characters:
"     —  The letters Ё and ё, Э and э, and Ы and ы (in pairs of capital and
"        small).  These are the letters in the Russian alphabet that are not
"        present in contemporary Bulgarian, so using the
"        old-bulgarian-phonetic keymap one can type in Russian, too.
"     —  The quotation marks „ “ ” ‘ ’ (used in the Bulgarian and English
"        quotation styles), as well as « » (Russian quotation style).
"     —  The characters §, №, – (en-dash), — (em-dash), …, •, ·, ±, °, ¬,
"        ¤, €, ‰, †, ‡, and ¶.
"     –  The characters from the old Bulgarian alphabet which are not present
"        today in the alphabet. These are:
"        S ѕ, І і, Ѹ ѹ Ꙋ ꙋ, Ѡ ѡ, Ѣ ѣ, Ꙗ ꙗ, Ѥ ѥ, Ѧ ѧ, Ѩ ѩ, Ѫ ѫ, Ѭ ѭ, Ѯ ѯ, Ѱ ѱ
"        Ѳ ѳ, Ѵ ѵ Ѷ ѷ, Ҁ ҁ, Ѿ ѿ
"
" The keymap also defines key combinations for grave and acute accents.
" (Grave accent is used in Bulgarian, acute in Russian, but both accents
" apply to other languages as well.)
"
" For details of what key or key combination maps to what character, please
" see below the map itself.
"
" See also http://www.math.bas.bg/bantchev/vim/kbdbul.html (in Bulgarian).

scriptencoding utf-8

let b:keymap_name = "oldpho"

loadkeymap
A       А       CYRILLIC CAPITAL LETTER A
B       Б       CYRILLIC CAPITAL LETTER BE
W       В       CYRILLIC CAPITAL LETTER VE
G       Г       CYRILLIC CAPITAL LETTER GHE
D       Д       CYRILLIC CAPITAL LETTER DE
E       Е       CYRILLIC CAPITAL LETTER IE
E::     Ё       CYRILLIC CAPITAL LETTER IO
V       Ж       CYRILLIC CAPITAL LETTER ZHE
Z       З       CYRILLIC CAPITAL LETTER ZE
I       И       CYRILLIC CAPITAL LETTER I
J       Й       CYRILLIC CAPITAL LETTER SHORT I
K       К       CYRILLIC CAPITAL LETTER KA
L       Л       CYRILLIC CAPITAL LETTER EL
M       М       CYRILLIC CAPITAL LETTER EM
N       Н       CYRILLIC CAPITAL LETTER EN
O       О       CYRILLIC CAPITAL LETTER O
P       П       CYRILLIC CAPITAL LETTER PE
R       Р       CYRILLIC CAPITAL LETTER ER
S       С       CYRILLIC CAPITAL LETTER ES
T       Т       CYRILLIC CAPITAL LETTER TE
U       У       CYRILLIC CAPITAL LETTER U
F       Ф       CYRILLIC CAPITAL LETTER EF
H       Х       CYRILLIC CAPITAL LETTER HA
C       Ц       CYRILLIC CAPITAL LETTER TSE
~       Ч       CYRILLIC CAPITAL LETTER CHE
{       Ш       CYRILLIC CAPITAL LETTER SHA
}       Щ       CYRILLIC CAPITAL LETTER SHCHA
Y       Ъ       CYRILLIC CAPITAL LETTER HARD SIGN
YI      Ы       CYRILLIC CAPITAL LETTER YERU
X       Ь       CYRILLIC CAPITAL LETTER SOFT SIGN
EQ      Ѣ       CYRILLIC CAPITAL LETTER YAT 
YE      Э       CYRILLIC CAPITAL LETTER REVERSED E
|       Ю       CYRILLIC CAPITAL LETTER YU
Q       Я       CYRILLIC CAPITAL LETTER YA
YA      Ѫ       CYRILLIC CAPITAL LETTER BIG YUS
a       а       CYRILLIC SMALL LETTER A
b       б       CYRILLIC SMALL LETTER BE
w       в       CYRILLIC SMALL LETTER VE
g       г       CYRILLIC SMALL LETTER GHE
d       д       CYRILLIC SMALL LETTER DE
e       е       CYRILLIC SMALL LETTER IE
e::     ё       CYRILLIC SMALL LETTER IO
v       ж       CYRILLIC SMALL LETTER ZHE
z       з       CYRILLIC SMALL LETTER ZE
i       и       CYRILLIC SMALL LETTER I
j       й       CYRILLIC SMALL LETTER SHORT I
k       к       CYRILLIC SMALL LETTER KA
l       л       CYRILLIC SMALL LETTER EL
m       м       CYRILLIC SMALL LETTER EM
n       н       CYRILLIC SMALL LETTER EN
o       о       CYRILLIC SMALL LETTER O
p       п       CYRILLIC SMALL LETTER PE
r       р       CYRILLIC SMALL LETTER ER
s       с       CYRILLIC SMALL LETTER ES
t       т       CYRILLIC SMALL LETTER TE
u       у       CYRILLIC SMALL LETTER U
f       ф       CYRILLIC SMALL LETTER EF
h       х       CYRILLIC SMALL LETTER HA
c       ц       CYRILLIC SMALL LETTER TSE
`       ч       CYRILLIC SMALL LETTER CHE
[       ш       CYRILLIC SMALL LETTER SHA
]       щ       CYRILLIC SMALL LETTER SHCHA
y       ъ       CYRILLIC SMALL LETTER HARD SIGN
yi      ы       CYRILLIC SMALL LETTER YERU
x       ь       CYRILLIC SMALL LETTER SOFT SIGN
eq      ѣ       CYRILLIC SMALL LETTER YAT
ye      э       CYRILLIC SMALL LETTER REVERSED E
\\      ю       CYRILLIC SMALL LETTER YU
q       я       CYRILLIC SMALL LETTER YA
ya      ѫ       CYRILLIC SMALL LETTER BIG YUS             
!!      §       SECTION SIGN (PARAGRAPH SIGN)
##      №       NUMERO SIGN
--      –       EN DASH
---     —       EM DASH
..      …       HORIZONTAL ELLIPSIS
``      “       LEFT DOUBLE QUOTATION  MARK
''      ”       RIGHT DOUBLE QUOTATION MARK
,,      „       DOUBLE LOW-9 QUOTATION MARK
`.      ‘       LEFT SINGLE QUOTATION MARK
'.      ’       RIGHT SINGLE QUOTATION MARK
<<      «       LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
>>      »       RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
**      •       BULLET
,.      ·       MIDDLE DOT      
+-      ±       PLUS-MINUS SIGN
^o      °       DEGREE SIGN
~~      ¬       NOT SIGN
@@      ¤       CURRENCY SIGN
$$      €       EURO SIGN
%%      ‰       PER MILLE SIGN
+|      †       DAGGER
++      ‡       DOUBLE DAGGER
||      ¶       PILCROW SIGN

" Accented characters cannot map onto cp1251 – use utf-8 file encoding.
" To apply an accent to a letter, type the corresponding key combination
" to the immediate right of that letter.
^`      <char-0x300>    COMBINING GRAVE ACCENT
^'      <char-0x301>    COMBINING ACUTE ACCENT
