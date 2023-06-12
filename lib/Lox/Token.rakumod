enum TokenType is export <
    LeftParen RightParen
    LeftBrace RightBrace Comma Dot
    Minus Plus Semicolon Slash Star

    Bang BangEqual Equal EqualEqual
    Greater GreaterEqual
    Less LessEqual

    # Literals
    Identifier
    StringLiteral
    NumberLiteral

    #Keywords
        And Else False Fun For If Nil Or Print Super
    This True Var While

    EOF

>;
subset LiteralType where Str | Bool | Num | Nil;

class Token is export {
    has TokenType $.type = EOF;
    has Str $.lexeme;
    has LiteralType $.literal;
    has Int $.line;

    method details {
        say "type is { $.type }, lexeme: { $.lexeme }, literal: { $.literal }, line: { $.line }";
    }
}
