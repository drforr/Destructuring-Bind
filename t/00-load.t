#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Lisp::Macro' ) || print "Bail out!\n";
}

diag( "Testing Lisp::Macro $Lisp::Macro::VERSION, Perl $], $^X" );
