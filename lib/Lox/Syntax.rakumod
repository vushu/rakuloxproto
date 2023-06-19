grammar Operators {
    token TOP { <equality>* }
    #    proto token tok {*}
    #    token operator:sym<false> { <sym> }
    #    token operator:sym<true> { <sym> }
    #    token operator:sym<,> { <sym> }
    token equality { <factor> }
    rule factor { <unary> <slash> <unary>               | <unary> <star> <unary>  }
    rule unary { <minus> <unary>               | <bang> <unary>               | <primary>  }

    token primary { <false> | <true> | <nil> | <identifier> }


    token plus { '+' }
    token minus { '-' }
    token bang { '!' }
    token nil { 'nil' }
    token false { 'false' }
    token true { 'true' }
    token slash { '/' }
    token star { '*' }
    token identifier { \w+ | \d+ }

}

grammar Syntax {
    token TOP { <equality>* }
    rule equality { <comparison>((<tok:sym<bang-equal>>|<tok:sym<equal-equal>>) <comparison>)*}
    rule comparison { <term> (('>'|'>='|'<'|'<=') <term>)*}
    rule term { <factor> (('-'|'+') <factor>)*}
    rule factor { <unary> (('/'|'*') <unary>)*}
    rule unary {('!' | '-') <unary> | <primary>}
    rule primary { 'true' | 'false' | 'nil' | 'this' | <number> | <string> | <identifier> |
    'super''.'<identifier> }
    rule string {
        '"' \w+ '"'
    }
    token identifier { <alpha> (<alpha> | <digit>)* }
    token number {
        <digit>+('.'<digit>+)?
    }

    proto token tok {*}
        token tok:sym<bang-equal> { '!=' }
    token tok:sym<equal-equal> { '==' }
}

class SyntaxPrinter {
   method TOP ($/) { $<equality>.<tok>.say }
#   method comparison ($/) { $<comparison>.say}
}

