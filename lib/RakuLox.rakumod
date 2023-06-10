unit module RakuLox;

use RakuLox::Scanner;
sub run() is export {
    my $s = Scanner.new;
    $s.say-hi("sdfadsfa");
}