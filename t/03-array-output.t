#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Destructuring::Bind', 'destructuring_bind' ) ||
      print "Bail out!\n";
}

# {{{ Error conditions
eval { ( ) = destructuring_bind };
ok( ! $@, "Binding to an empty array is a no-op" );

# Same error as with a bare scalar, pay heed.
#
eval { ( 'foo' ) = destructuring_bind };
is( $@, "Cannot destructuring_bind to a constant value" );

eval { [ ] = destructuring_bind };
ok( ! $@, "Binding to an empty arrayref is a no-op" );
# }}}

# {{{ Basic array binding
my @array = destructuring_bind;
is_deeply( [ @array ], [ ], "Binding no input gets us an empty array" );

@array = ( 27, 69 );
@array = destructuring_bind;
is_deeply( [ @array ], [ ], "Binding no input clears an existing array" );

@array = destructuring_bind 27;
is_deeply(
  [ @array ], [ 27 ], "Binding scalar to an array assigns the first slot"
);

@array = destructuring_bind 27;
is_deeply(
  [ @array ],
  [ 27 ],
  "Binding scalar to an array assigns the first slot"
);

@array = destructuring_bind [ 27 ];
is_deeply(
  [ @array ],
  [ [ 27 ] ],
  "Binding arrayref to an array assigns the first slot"
);

@array = destructuring_bind { foo => 27 };
is_deeply(
  [ @array ],
  [ { foo => 27 } ],
  "Binding hashref to an array assigns the first slot"
);

# XXX May not work
#
@array = destructuring_bind bless { }, 'Foo';
is_deeply(
  [ @array ],
  [ bless { }, 'Foo' ],
  "Binding blessed object to an array assigns the first slot"
);

@array = destructuring_bind ( undef, undef );
is_deeply(
  [ @array ], [ undef, undef ], "Binding undef list to an array assigns undefs"
);

@array = qw( foo bar baz );
@array = destructuring_bind ( 'foo', 27 );
is_deeply(
  [ @array ], [ 'foo', 27 ], "Binding list to an array assigns all slots"
);
# }}}

# {{{ Array slices
@array = ( 1, 2 );
@array[0] = destructuring_bind;
is_deeply(
  [ @array ],
  [ undef, 2 ],
  "Binding slice [0] of array to undef doesn't undef the entire array"
);

@array[0] = destructuring_bind 27;
is_deeply(
  [ @array ],
  [ 27, 2 ],
  "Binding slice [0] of array to 27 only affects sliced element"
);

@array[1] = destructuring_bind 'foo';
is_deeply(
  [ @array ],
  [ 27, 'foo' ],
  "Binding slice [1] of array to 'foo' only affects next sliced element"
);

@array[1] = destructuring_bind 'bar', 'qux';
is_deeply(
  [ @array ],
  [ 27, 'foo' ],
  "Binding slice [1] of array to 27 ignores extra elements"
);

@array = ( 1, 2, 3, 4, 5 );
@array[1,2] = destructuring_bind;
is_deeply(
  [ @array ],
  [ 1, undef, undef, 4, 5 ],
  "Binding slice [1,2] of array to undef list only affects sliced eleemnts"
);
@array[1,2] = destructuring_bind( 'foo', 'bar' );
is_deeply(
  [ @array ],
  [ 1, 'foo', 'bar', 4, 5 ],
  "Binding slice [1,2] of array to defined list only affects sliced eleemnts"
);

@array[1..3] = destructuring_bind( 'foo', 'bar', 'qux'  );
is_deeply(
  [ @array ],
  [ 1, 'foo', 'bar', 'qux', 5 ],
  "Binding slice [1..3] of array to defined list only affects sliced eleemnts"
);
# }}}
