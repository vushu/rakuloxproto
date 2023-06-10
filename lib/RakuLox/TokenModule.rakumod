unit module TokenModule;
enum TokenType is export <LeftParen RightParen EOF>;
subset LiteralType where Str | Bool | Num;

class Token is export {
    has TokenType $.type = EOF;
    has Str $.lexeme;
    has LiteralType $.literal;
    has Int $.line;

    method details {
        say "type is {$.type}, lexeme: {$.lexeme}, literal: {$.literal}, line: {$.line}";
    }

}