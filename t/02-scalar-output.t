#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Lisp::Macro' ) || print "Bail out!\n";
}

diag( "Testing Lisp::Macro $Lisp::Macro::VERSION, Perl $], $^X" );

# You just *know* someone's going to try this.
#
eval {
  1 = destructuring_bind;
};
is( $@, "Cannot destructuring_bind to a constant value" );

my ( $c ) = destructuring_bind;
ok( ! $c, "Scalar is undef" );

( $c ) = destructuring_bind;
ok( ! $c, "Can assign outside of a my() context" );

( $c ) = destructuring_bind( undef );
ok( ! $c, "Passes undef through cleanly" );

( $c ) = destructuring_bind( undef );
ok( ! $c, "Passes undef through cleanly" );

( $c ) = destructuring_bind( () );
ok( ! $c, "Passes empty list through cleanly" );

( $c ) = destructuring_bind( "" );
is( $c, "", "Passes empty string" );

( $c ) = destructuring_bind( 0 );
is( $c, 0, "Assigns 0" );

( $c ) = destructuring_bind( 1 );
is( $c, 1, "Assigns 1" );

( $c ) = destructuring_bind( 27 );
is( $c, 27, "Assigns 27" );

( $c ) = destructuring_bind( 'foo' );
is( $c, 'foo', "Assigns 'foo'" );

( $c ) = destructuring_bind( qr/foo/ );
is( ref( $c ), 'Regexp', "Assigns regexp" );

( $c ) = destructuring_bind( [ ] );
is_deeply( $c, [ ], "Assigns empty arrayref");

( $c ) = destructuring_bind( { } );
is_deeply( $c, { }, "Assigns empty hashref");

( $c ) = destructuring_bind( [ 'foo' ] );
is_deeply( $c, [ 'foo' ], "Assigns arrayref with one item" );

( $c ) = destructuring_bind( { foo => 27 } );
is_deeply( $c, { foo => 27 }, "Assigns hashref with one item" );
