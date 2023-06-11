use Lox::Token;
class Scanner is export {
    has Str $.source;
    has Token @.tokens;
    has Int $.start;
    has Int $.current;
    has Int $.line;

    method scan {
        say " hi "
    }

    method say-hi($name) {
        say "Hi " ~ $name;
    }
}
