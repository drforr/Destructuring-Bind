#!perl

use Test::More tests => 1;

BEGIN {
    use_ok( 'Destructuring::Bind' ) || print "Bail out!\n";
}

=pod

my ( $a, $b, [ $c, $d ], @foo ) = destructuring_bind( @_ );

=cut
