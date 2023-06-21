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
    rule equality { <comparison>[['!='|'==']<comparison>]*}
    rule comparison { <term>[[
        <tok:sym<gt>>|
        <tok:sym<ge>>|
        <tok:sym<lt>>|
        <tok:sym<le>>]<term>]*
    }
    rule term { <factor> [['-'|'+'] <factor>]*}
    rule factor { <unary> [['/'|'*'] <unary>]*}
    rule unary {['!'| '-'] <unary>|<primary>}
    rule primary {
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

    proto token tok {*}
    token tok:sym<(> { <sym> }
    token tok:sym<)> { <sym> }
    token tok:sym<{> { <sym> }
    token tok:sym<}> { <sym> }
    token tok:sym<,> { <sym> }
    token tok:sym<.> { <sym> }
    token tok:sym<-> { <sym> }
    token tok:sym<+> { <sym> }
    token tok:sym<;> { <sym> }
    token tok:sym</> { <sym> }
    token tok:sym<*> { <sym> }

    token tok:sym<!=> { <sym> }
    token tok:sym<==> { <sym> }
    token tok:sym<gt> { '>' }
    token tok:sym<ge> { '>=' }
    token tok:sym<lt> { '<' }
    token tok:sym<le> { '<=' }
    token tok:sym<and> { <sym> }
    token tok:sym<else> { <sym> }
    token tok:sym<false> { <sym> }
    token tok:sym<true> { <sym> }
    token tok:sym<fun> { <sym> }
    token tok:sym<for> { <sym> }
    token tok:sym<if> { <sym> }
    token tok:sym<nil> { <sym> }
    token tok:sym<or> { <sym> }
    token tok:sym<print> { <sym> }
    token tok:sym<super> { <sym> }
    token tok:sym<this> { <sym> }
    token tok:sym<var> { <sym> }
    token tok:sym<while> { <sym> }
    token tok:sym<eof> { <sym> }


}

class SyntaxPrinter {
   method TOP ($/) {
#       make $<tok>.made;
   }
#   method tok:sym<bang-equal> ($/) { say "(!="; }
   method equality ($/) {  make ($<tok> $<comparison>).made if $<tok>; }
#   method comparison ($/) { say $<tok>?? "( {$<tok>} {$<term>})" !! ""; }
#   method comparison ($/) { say "({$<tok>} {$<term>})"; }
#   method tok ($/) { make(say "sdfasdfsadfasd"); }
#
#   method comparison ($/) { $<comparison>.say}
}

