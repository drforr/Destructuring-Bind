#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Destructuring::Bind', 'destructuring_bind' ) ||
      print "Bail out!\n";
}

# {{{ Basic hash binding
my %hash = destructuring_bind;
is_deeply( [ %hash ], [ ], "Binding no input gets us an empty hash" );

%hash = { foo => 27 );
%hash = destructuring_bind;
is_deeply( [ %hash ], [ ], "Binding no input clears an existing hash" );

eval { %hash = destructuring_bind 27 };
like( $@, qr/Odd number of elements in destructuring_bind/ );

%hash = destructuring_bind foo => 27;
is_deeply(
  [ %hash ],
  [ foo => 27 ],
  "Binding pair to an hash assigns the first pair"
);

%hash = destructuring_bind foo => [ 27 ];
is_deeply(
  [ %hash ],
  [ foo => [ 27 ] ],
  "Binding pair with arrayref to a hash assigns the first pair"
);

%hash = destructuring_bind foo => { foo => 27 };
is_deeply(
  [ %hash ],
  [ foo => { foo => 27 } ],
  "Binding pair with hashref to a hash assigns the first pair"
);

# XXX May not work
#
%hash = destructuring_bind foo => bless { }, 'Foo';
is_deeply(
  [ %hash ],
  [ foo => bless { }, 'Foo' ],
  "Binding pair with object to a hash assigns the first pair"
);

%hash = destructuring_bind ( undef, undef );
is_deeply(
  [ %hash ],
  [ undef => undef ],
  "Binding undef pair to a hash assigns undefs to the first pair"
);

%hash = ( foo => bar, qux => 42 );
%hash = destructuring_bind ( foo => 27 );
is_deeply(
  [ %hash ], [ foo => 27 ], "Binding list to a hash assigns all slots"
);
# }}}

# {{{ Hash slices
#
# XXX May not work, damn hash randomizer
#
%hash = ( a => 1, b => 2 );
%hash{a} = destructuring_bind;
is_deeply(
  [ %hash ],
  [ a => undef, b => 2 ],
  "Binding slice {a} of hash to undef doesn't undef the entire array"
);

%hash{a} = destructuring_bind 27;
is_deeply(
  [ %hash ],
  [ a => 27, b => 2 ],
  "Binding slice {a} of array to 27 only affects sliced element"
);

%hash{b} = destructuring_bind 'foo';
is_deeply(
  [ %hash ],
  [ a => 27, b => 'foo' ],
  "Binding slice {b} of hash to 'foo' only affects next sliced element"
);

%hash{b} = destructuring_bind 'bar', 'qux';
is_deeply(
  [ %hash ],
  [ a => 27, b => 'bar' ],
  "Binding slice {b} of array to 'bar' ignores extra elements"
);

# XXX May not work
%hash = ( a => 1, b => 2, c => 3, d => 4, e => 5 );
%hash{b,c} = destructuring_bind;
is_deeply(
  [ %hash ],
  [ a => 1, b => undef, c => undef, d => 4, e => 5 ],
  "Binding slice {b,c} of hash to undef list only affects sliced eleemnts"
);
%hash{b,c} = destructuring_bind( 'foo', 'bar' );
is_deeply(
  [ %hash ],
  [ a => 1, b => 'foo', c => 'bar', d => 4, e => 5 ],
  "Binding slice {b,c} of hash to defined list only affects sliced eleemnts"
);

%hash{'a'..'c'} = destructuring_bind( 'foo', 'bar', 'qux'  );
is_deeply(
  [ %hash ],
  [ a => 1, b => 'foo', c => 'bar', d => 'qux', e => 5 ],
  "Binding slice [1..3] of array to defined list only affects sliced eleemnts"
);
# }}}
