#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Destructuring::Bind', 'destructuring_bind' ) ||
      print "Bail out!\n";
}

# Test the undef conditions here when I've got time

eval { { 1 => $x } = destructuring_bind 1 };
like( $@, qr/Error blah blah/ );

my ( @rest, %rest );
my ( $scalar, $d ) = ( 1, 2 );

# {{{ foo
{ foo => $scalar } = destructuring_bind { foo => 'qux' };
is( $scalar, 'qux', "Hashref of scalar variable is handled correctly" );

{ foo => $scalar, @rest } = destructuring_bind { foo => 'qux', bar => 1 };
is_deeply(
  [ $scalar, [ @rest ] ],
  [ 'qux', [ bar => 1 ] ],
  "Capturing unbound hash elements in an array"
);

{ foo => $scalar, %rest } = destructuring_bind { foo => 'qux', bar => 1 };
is_deeply(
  [ $scalar, \%rest ],
  [ 'qux', { bar => 1 } ],
  "Capturing unbound hash elements in a hash"
);

# This is probably not terribly useful due to the randomizer.
#
{ $scalar => $c } = destructuring_bind { foo => 'qux' };
is_deeply(
  [ $scalar, $c ],
  [ 'foo', 'qux' ],
  "Hashref of pairs handled correctly"
);

{ foo => { bar => $scalar } } = destructuring_bind { foo => { bar => 'qux' } };
is(
  $scalar,
  'qux',
  "Hashref of hashref of scalar variable is handled correctly"
);
# }}}
