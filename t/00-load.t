#!perl -T

use Test::More tests => 1;

BEGIN {
  use_ok( 'Destructuring::Bind', 'destructuring_bind' ) ||
    print "Bail out!\n";
}

diag( "Testing Destructuring::Bind $Destructuring::Bind::VERSION, Perl $], $^X" );
