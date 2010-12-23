#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Destructuring::Bind', 'destructuring_bind' ) ||
      print "Bail out!\n";
}

# Test the undef conditions here when I've got time

eval { [ $x ] = destructuring_bind 1 };
like( $@, qr/Error blah blah/ );

my ( $scalar, $d ) = ( 1, 2 );

=cut

# {{{ foo
[ $scalar ] = destructuring_bind [ 'foo' ];
is( $scalar, 'foo', "Arrayref of scalar variable is handled correctly" );

[ $scalar ] = destructuring_bind [ [ 'foo' ] ];
is_deeply(
  $scalar,
  [ 'foo' ],
  "Arrayref handles nested variables"
);

# From here beyond it might be a good idea to break this into a separate file
# but it seems wrong, or at least not worthwhile, given how small the
# actual aref tests will be.
#
[ [ $scalar ] ] = destructuring_bind [ [ 'foo' ] ];
is_deeply(
  $scalar,
  'foo',
  "Arrayref handles nested arrayref of variable"
);

[ $c, $d ] = destructuring_bind [ 'foo', 1 ];
is_deeply(
  [ $c, $d ],
  [ 'foo', 1 ],
  "Two variables in an aref"
);

[ $c, $d ] = destructuring_bind [ 'foo', [ 1 ] ];
is_deeply(
  [ $c, $d ],
  [ 'foo', [ 1 ] ],
  "Two variables in an aref, one value is a reference itself"
);

[ $c, [ $d ] ] = destructuring_bind [ 'foo', [ 1 ] ];
is_deeply(
  [ $c, $d ],
  [ 'foo', 1 ],
  "Two variables in an aref, nested references"
);

[ $c, [ $d ] ] = destructuring_bind [ [ 'foo' ], [ 1 ] ];
is_deeply(
  [ $c, $d ],
  [ [ 'foo' ], 1 ],
  "Two variables in an aref, both nested references"
);

[ [ $c ], $d ] = destructuring_bind [ [ 'foo' ], [ 1 ] ];
is_deeply(
  [ $c, $d ],
  [ 'foo', [ 1 ] ],
  "Two variables in an aref, nested references"
);

[ [ $c ], [ $d ] ] = destructuring_bind [ [ 'foo' ], [ 1 ] ];
is_deeply(
  [ $c, $d ],
  [ 'foo', 1 ],
  "Two variables in an aref, nested references"
);
# }}}
