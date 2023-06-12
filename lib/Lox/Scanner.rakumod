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
        @.tokens.push(Token.new(type => TokenType::EOF, lexeme => "", literal => Nil, :$.line));
    }

    method !add-token(TokenType $type, LiteralType $literal-type = Nil) {
        say "current is start: { $.start }, current: { $.current }";
        my $text = @.source-code[$.start ..^ $.current].join;
        @.tokens.push(Token.new(:$type, lexeme => $text, literal => $literal-type, line => $.line));
    }

    method !match(Str $expected --> Bool) {
        return False if self!is-at-end;
        return False if self!is-at-end;
        $!current++;
        return True;
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
        say "character: ", $c;
        given $c {
            when '(' { self!add-token(TokenType::LeftParen); }
            when ')' { self!add-token(TokenType::RightParen); }
            when '{' { self!add-token(TokenType::LeftBrace); }
            when '}' { self!add-token(TokenType::RightBrace); }
        }
    }
}
