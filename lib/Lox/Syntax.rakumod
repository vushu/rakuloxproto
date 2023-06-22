grammar Syntax {
    token TOP { <equality>* }
    rule equality { <comparison>[['!='|'==']<comparison>]*}
    rule comparison { <term>[[
        <tok:sym<gt>>|
        <tok:sym<ge>>|
        <tok:sym<lt>>|
        <tok:sym<le>>]<term>]*
    }
    rule term { <factor>('-'|'+'<factor>)*}
    rule factor { <unary>(['/'|'*']<unary>)*}
    rule unary {[<tok:sym<!>>|<tok:sym<->>][<unary>|<primary>]}
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
#    token unary-tok {'!'|'-'}
    token identifier { <alpha>[<alpha>|<digit>]* }
    token number {
        <digit>+['.'<digit>+]?
    }

    token unary-tok { ['!'|'-'] }

    token fact-tok {['/'|'*']}
    proto token tok {*}
    token tok:sym<(> { <sym> }
    token tok:sym<)> { <sym> }
    token tok:sym<{> { <sym> }
    token tok:sym<}> { <sym> }
    token tok:sym<,> { <sym> }
    token tok:sym<.> { <sym> }
    token tok:sym<-> { <sym> }
    token tok:sym<+> { <sym> }
    token tok:sym<!> { <sym> }
    token tok:sym<;> { <sym> }
#    token tok:sym</> { <sym> }
#    token tok:sym<*> { <sym> }

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
       $<equality>;
#       $<term>.made;
   }

   method term ($/) { $<factor> }

   method factor ($/) {
        say "lololo0000000000000";
#            say $<primary>;
   } #   method tok:sym<bang-equal> ($/) { say "(!="; }
#   method equality ($/) { say ($<tok>, $<comparison>); }
#   method equality ($/) { $<comparison>; }
#   method comparison ($/) { $<term>; }
#   method term ($/) { $<factor>; }
#   method factor ($/) { $<unary>; }
#   method unary ($/) { $<unary> | $<primary>; }
#   method primary ($/) { $<unary> | $<identifier>; }
#   method identifier ($/) { $<unary> | $<number> | $<identifier>; }
#   method tok:sym<add> ($/) { make [+] $<number>;}
   #   method comparison ($/) { say $<tok>?? "( {$<tok>} {$<term>})" !! ""; }
#   method comparison ($/) { say "({$<tok>} {$<term>})"; }
#   method tok ($/) { make(say "sdfasdfsadfasd"); }
#
#   method comparison ($/) { $<comparison>.say}
}

grammar Lox {
    token TOP { <term> }
    rule term { <factor>('-'|'+'<factor>)*}
    rule factor { <unary>(['/'|'*']<unary>)*}
    rule unary {('!'|'-')[<unary>|<primary>]}
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
    #    token unary-tok {'!'|'-'}
    token identifier { <alpha>[<alpha>|<digit>]* }
    token number {
        <digit>+['.'<digit>+]?
    }
#    token tok { | '==' }
}

class LoxInterpreter {
    method TOP ($/) { make $<binary-op>.made}
    method binary-op:sym<equality> ($/)
    {
        my $t = $<tok>.Str;
        if $t eq "!=" {
            make [!=] $<num>;
        } else {
            make [==] $<num>;
        }
    }
}

