use Lox::Token;
class Scanner is export {
    has @.source-code is Array[Str];
    has @.tokens of Token is built;
    has Int $.start = 0;
    has Int $.current = 0;
    has Int $.line = 0;

    submethod BUILD (:$code) {
        @!source-code = Array[Str].new($code.comb);
    }

    method !advance(--> Str) {
        @!source-code[$!current++];
    }

    method scan-tokens(--> Array[Token]) {
        while not self!is-at-end {
            $!start = $.current;
            self!scan-token;
        }
        @.tokens.push(Token.new(type => EOF, lexeme => "", literal => Nil, :$.line));
    }

    method !add-token(TokenType $type, LiteralType $literal-type = Nil) {
        say "current is start: { $.start }, current: { $.current }";
        my $text = @.source-code[$.start ..^ $.current].join;
        say "lexeme: { $text }";
        @.tokens.push(Token.new(:$type, lexeme => $text, literal => $literal-type, line => $.line));
    }

    method !match(Str $expected --> Bool) {
        return Bool::False if self!is-at-end;
        return Bool::False if @!source-code[$.current] ne $expected;
        $!current++;
        Bool::True;
    }

    method !peek(--> Str) {
        return '\0' if self!is-at-end;
        $.source-code[$.current];
    }

    method !peek-next(--> Str) {
        return '\0' if $.current + 1 >= $.source-code.chars;
        $.source-code[$.current + 1];
    }

    method !is-at-end {
        $.current >= @!source-code.elems;
    }

    method !scan-token {
        my Str $c = self!advance;
        #        say "character: ", $c;
        given $c {
            when '(' { self!add-token(LeftParen); }
            when ')' { self!add-token(RightParen); }
            when '{' { self!add-token(LeftBrace); }
            when '}' { self!add-token(RightBrace); }
            when ',' { self!add-token(Comma); }
            when '.' { self!add-token(Dot); }
            when '-' { self!add-token(Minus); }
            when '+' { self!add-token(Plus); }
            when ';' { self!add-token(Semicolon); }
            when '*' { self!add-token(Star); }
            when '!' { self!add-token(self!match('=') ?? BangEqual !! Bang); }
            when '=' { self!add-token(self!match('=') ?? EqualEqual !! Equal); }
            when '<' { self!add-token(self!match('=') ?? LessEqual !! Less); }
            when '>' { self!add-token(self!match('=') ?? GreaterEqual !! Greater); }
            when '/' {
                if self!match('/') {
                    while self!peek ne '\n' and not self!is-at-end {
                        self!advance;
                    }
                }
                else {
                    self!add-token(Slash);
                }
            }
            when ' ', '\r', '\t' {}
            when '\n' {
                $!line++;
                say "new line {$.line}";
            }
            when '"' {}
            default {

            }
        }
    }
}
