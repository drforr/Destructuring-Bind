#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Lisp::Macro' ) || print "Bail out!\n";
}

diag( "Testing Lisp::Macro $Lisp::Macro::VERSION, Perl $], $^X" );

# {{{ Binding to constant
@
# You just *know* someone's going to try this.
#
eval { 0 = destructuring_bind };
is( $@, "Cannot destructuring_bind to a constant value" );

eval { 1 = destructuring_bind };
is( $@, "Cannot destructuring_bind to a constant value" );

eval { 27 = destructuring_bind };
is( $@, "Cannot destructuring_bind to a constant value" );

eval { 'foo' = destructuring_bind };
is( $@, "Cannot destructuring_bind to a constant value" );

use constant BLAH => 32;
eval { BLAH = destructuring_bind };
is( $@, "Cannot destructuring_bind to a constant value" );

# }}}

# {{{ Scalar tests
#
# On to the real scalar tests
#
my ( $scalar ) = destructuring_bind;
ok( ! $scalar, "Scalar is undef" );

( $scalar ) = destructuring_bind;
ok( ! $scalar, "Can assign in a list context without 'my'" );

$scalar = destructuring_bind;
ok( ! $scalar, "Can assign outside of a my() context" );

$scalar = destructuring_bind( undef );
ok( ! $scalar, "Passes undef through cleanly" );

$scalar = destructuring_bind( undef );
ok( ! $scalar, "Passes undef through cleanly" );

$scalar = destructuring_bind( () );
ok( ! $scalar, "Passes empty list through cleanly" );

$scalar = destructuring_bind( "" );
is( $scalar, "", "Passes empty string" );

$scalar = destructuring_bind( 0 );
is( $scalar, 0, "Binds 0 to scalar" );

$scalar = destructuring_bind( 1 );
is( $scalar, 1, "Binds 1 to scalar" );

$scalar = destructuring_bind( 27 );
is( $scalar, 27, "Binds 27 to scalar" );

$scalar = destructuring_bind( 'foo' );
is( $scalar, 'foo', "Binds 'foo' to scalar" );

$scalar = destructuring_bind( qr/foo/ );
is( ref( $scalar ), 'Regexp', "Binds regexp to scalar" );

$scalar = destructuring_bind( [ ] );
is_deeply( $scalar, [ ], "Binds arrayref to scalar" );

$scalar = destructuring_bind( { } );
is_deeply( $scalar, { }, "Binds hashref to scalar" );

# Note that this behavior differs from [$x]=destructuring_bind [27]
# Which sets $x to 27
#
$scalar = destructuring_bind( [ 'foo' ] );
is_deeply( $scalar, [ 'foo' ], "Binds arrayref with content to scalar" );

$scalar = destructuring_bind( { foo => 27 } );
is_deeply( $scalar, { foo => 27 }, "Binds hashref with content to scalar" );

# }}}

# {{{ Binding more than one list element to a scalar only gets the *first*.
$scalar = destructuring_bind( 'foo', 27 );
is(
  $scalar, 'foo',
  "Binding more than one list element to a scalar gets just the first"
);

$scalar = destructuring_bind( undef, 27 );
ok(
  ! $scalar, 
  "Binding more than one list element to a scalar gets the first even if undef"
);
# }}}

# {{{ Array element tests
#
my @array;

$array[0] = destructuring_bind;
is_deeply(
  [ @array ],
  [ ],
  "Binding nothing to an undef array element alters nothing"
);

$array[0] = destructuring_bind 0;
is_deeply(
  [ @array ],
  [ 0 ],
  "Binding 0 to an array element"
);

$array[0] = destructuring_bind '';
is_deeply(
  [ @array ],
  [ '' ],
  "Binding '' to an array element"
);

$array[0] = destructuring_bind 'foo';
is_deeply(
  [ @array ],
  [ 'foo' ],
  "Binding 'foo' to an array element"
);

$array[1] = destructuring_bind 27
is_deeply(
  [ @array ],
  [ 'foo', 27 ],
  "Binding 27 to the next array element"
);
# }}}

# {{{ Hash key tests
#
my %hash;

$hash{foo} = destructuring_bind;
is_deeply(
  \%hash,
  { },
  "Binding undef doesn't autovivify a hash key"
);

$hash{foo} = destructuring_bind 0;
is_deeply(
  \%hash,
  { foo => 0 },
  "Binding 0 to a hash key"
);

$hash{foo} = destructuring_bind '';
is_deeply(
  \%hash,
  { foo => '' },
  "Binding '' to a hash key"
);

$hash{foo} = destructuring_bind 'bar';
is_deeply(
  \%hash,
  { foo => 'bar' },
  "Binding 'bar' to a hash key"
);

$hash{1} = destructuring_bind 27
is_deeply(
  \%hash,
  { foo => 'bar', 1 => 27 },
  "Binding 27 to a new hash key"
);
# }}}

# {{{ Array element tests
#
my $arrayref = [];

$arrayref->[0] = destructuring_bind;
is_deeply(
  $arrayref,
  [ ],
  "Binding nothing to an undef arrayref element alters nothing"
);

$arrayref->[0] = destructuring_bind 0;
is_deeply(
  $arrayref,
  [ 0 ],
  "Binding 0 to an arrayref element"
);

$arrayref->[0] = destructuring_bind '';
is_deeply(
  $arrayref,
  [ '' ],
  "Binding '' to an arrayref element"
);

$arrayref->[0] = destructuring_bind 'foo';
is_deeply(
  $arrayref,
  [ 'foo' ],
  "Binding 'foo' to an arrayref element"
);

$arrayref->[1] = destructuring_bind 27
is_deeply(
  $arrayref,
  [ 'foo', 27 ],
  "Binding 27 to the next arrayref element"
);
# }}}

# {{{ Hash key tests
#
my $hashref = {};

$hashref->{foo} = destructuring_bind;
is_deeply(
  $hashref,
  { },
  "Binding undef doesn't autovivify a hashref key"
);

$hashref->{foo} = destructuring_bind 0;
is_deeply(
  $hashref,
  { foo => 0 },
  "Binding 0 to a hashref key"
);

$hashref->{foo} = destructuring_bind '';
is_deeply(
  $hashref,
  { foo => '' },
  "Binding '' to a hashref key"
);

$hashref->{foo} = destructuring_bind 'bar';
is_deeply(
  $hashref,
  { foo => 'bar' },
  "Binding 'bar' to a hashref key"
);

$hashref->{1} = destructuring_bind 27
is_deeply(
  $hashref,
  { foo => 'bar', 1 => 27 },
  "Binding 27 to a new hashref key"
);
# }}}
