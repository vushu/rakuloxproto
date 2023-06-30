grammar Lox {
    token TOP { <unary>+  }
    proto rule unary { * }
#    rule unary:sym<bang> { '!' <unary>|<primary> }
    rule unary:sym<minus> { '-' <primary> }

    proto token primary { * }
    token primary:sym<number> { <number> }

#    token primary {
#        | 'true'
#        | 'false'
#        | 'nil'
#        | 'this'
#        | <number>
#        | <string>
#        | <identifier>
#        | 'super''.'<identifier>
    rule string {
        # todo add except for "
        '"' \w+ '"'
    }
    token identifier { <alpha>[<alpha>|<digit>]* }
    token number {
#        <digit>+['.'<digit>+]?
        \d+
    }
}

class LoxInterpreter {

    method TOP ($/) { make $<unary>; }

    method unary:sym<bang> ($/) {
        make  !$/.Int;
    }

    method unary:sym<minus> ($/) {
        say $/, " <- ";
        make [-] $/, 0;
    }

#    method primary:sym<number>($/) {
#        say "hererere $/";
#        make [+] $/, 1;
#    }

#    method number ($/) {
#        say "number herer";
#    }


}

