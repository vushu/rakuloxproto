unit module RakuLox;

use RakuLox::Scanner;
# class Jujuman is export {

#     method say-yo($name) {
#         say "yo ", $name;
#     }
# }
# # sub MAIN {
# #     my $s = Scanner.new("dfasdfa");
# #     $s.scan;
# }
sub run() is export {
    my $s = Scanner.new;
    $s.say-hi("sdfadsfa");
}