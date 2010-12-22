#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Lisp::Macro' ) || print "Bail out!\n";
}

diag( "Testing Lisp::Macro $Lisp::Macro::VERSION, Perl $], $^X" );

my ( $scalar, $c ) = ( 1, 2 );
my ( @array, @d ) = ( 3, 4 ); # Doesn't init @d of course
my ( %hash, %e ) = ( 5 => 6 ); # Same here

( $scalar, $c ) = destructuring_bind;
is_deeply(
  [ $scalar, $c ],
  [ undef, undef ],
  "Bind undef to two scalars, both are undef'd"
);

( $scalar, $c ) = destructuring_bind 1;
is_deeply(
  [ $scalar, $c ],
  [ 1, undef ],
  "Bind 1 to one scalar, undef to the other"
);

( $scalar, $c ) = destructuring_bind 1, 2;
is_deeply(
  [ $scalar, $c ],
  [ 1, 2 ],
  "Bind 1 to one scalar, 2 to the other"
);

( $scalar, $c ) = destructuring_bind undef, 2;
is_deeply(
  [ $scalar, $c ],
  [ undef, 2 ],
  "Bind undef to one scalar, 2 to the other"
);

( $scalar, @array ) = destructuring_bind;
is_deeply(
  [ $scalar, [ @array ] ],
  [ undef, [ ] ],
  "Bind undef to a scalar and an array"
);

( $scalar, @array ) = destructuring_bind 1;
is_deeply(
  [ $scalar, [ @array ] ],
  [ 1, [ ] ],
  "Bind 1 to scalar, undef to the array;
);

( $scalar, @array ) = destructuring_bind 1, 2;
is_deeply(
  [ $scalar, [ @array ] ],
  [ 1, [ 2 ] ],
  "Bind 1 to scalar, ( 2 ) to the array;
);

( $scalar, @array ) = destructuring_bind 1, 2, 3;
is_deeply(
  [ $scalar, [ @array ] ],
  [ 1, [ 2, 3 ] ],
  "Bind 1 to scalar, ( 2, 3 ) to the array;
);

( @array, $scalar ) = destructuring_bind;
is_deeply(
  [ [ @array ], $scalar ],
  [ [ undef ], undef ],
  "Bind undef to array, scalar (reverse the order)"
);

( @array, $scalar ) = destructuring_bind 1;
is_deeply(
  [ [ @array ], $scalar ],
  [ [ 1 ], undef ],
  "Bind 1 to array, scalar (reverse the order)"
);

( @array, $scalar ) = destructuring_bind 1, 2;
is_deeply(
  [ [ @array ], $scalar ],
  [ [ 1, 2 ], undef ],
  "Prove that arrays still consume all of their arguments"
);
