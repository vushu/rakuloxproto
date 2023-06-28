grammar Lox {
    token TOP { <statement>+  }
    rule statement { <expression>+ % <operator> }
    rule expression { <unary>+ % <operator> }
    token operator {
        | 'or'
        | 'and'
        | '!='
        | '=='
        | '>='
        | '>'
        | '<='
        | '<'
        | '-'
        | '+'
        | '/'
        | '*'
        | '!'
    }

    proto rule unary { * }
    rule unary:sym<bang> { <operator> <unary>|<primary> }
    rule unary:sym<minus> { <operator> <unary>|<primary> }
    token primary {
        | 'true'
        | 'false'
        | 'nil'
        | 'this'
        | <number>
        | <string>
        | <identifier>
        | 'super''.'<identifier>
    }
    rule string {
        # todo add except for "
        '"' \w+ '"'
    }
    token identifier { <alpha>[<alpha>|<digit>]* }
    token number {
        <digit>+['.'<digit>+]?
    }
}

class LoxInterpreter {

    method TOP ($/) { make $<expression>.made; }

#    method statement ($/) { $<expression>; }
    method expression ($/) {
        say "saying stuff", $<unary>;
        make [*] $<unary>;
    }
}

