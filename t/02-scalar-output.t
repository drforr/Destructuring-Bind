#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Destructuring::Bind', 'destructuring_bind' ) ||
      print "Bail out!\n";
}

# {{{ Bind errors
#
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

# {{{ Unused variables must be unaffected
{
  my $scalar = destructuring_bind;
  ok( ! $scalar, "Binding undef in scalar context" );
}

{
  my ( $scalar ) = destructuring_bind;
  ok( ! $scalar, "Binding undef in list context" );
}

{
  my $scalar = 27;
  $scalar = destructuring_bind;
  is( $scalar, 27, "Binding in scalar context only affects used variables" );
}

{
  my $scalar = 27;
  ( $scalar ) = destructuring_bind;
  is( $scalar, 27, "Binding in list context only affects used variables" );
}
# }}}

# {{{ Binding undef to scalar binds
{
  my $scalar = destructuring_bind undef;
  ok( ! $scalar, "Binding undef in scalar context" );
}

{
  my ( $scalar ) = destructuring_bind undef;
  ok( ! $scalar, "Binding undef in list context" );
}

{
  my $scalar;
  $scalar = destructuring_bind undef;
  ok( ! $scalar, "Binding undef in scalar context, no 'my'" );
}

{
  my $scalar;
  ( $scalar )  = destructuring_bind undef;
  ok( ! $scalar, "Binding undef in list context, no 'my'" );
}
# }}}

# {{{ Binding false values to scalar binds
{
  my $scalar = destructuring_bind 0;
  is( $scalar, 0, "Binding 0 in scalar context" );
}

{
  my $scalar = destructuring_bind 0.0;
  is( $scalar, 0.0, "Binding 0.0 in scalar context" );
}

{
  my $scalar = destructuring_bind '';
  is( $scalar, '', "Binding '' in scalar context" );
}

{
  my $scalar = destructuring_bind '0';
  is( $scalar, '0', "Binding '0' in scalar context" );
}

{
  my ( $scalar ) = destructuring_bind 0;
  is( $scalar, 0, "Binding 0 in list context" );
}

{
  my ( $scalar ) = destructuring_bind 0.0;
  is( $scalar, 0.0, "Binding 0.0 in list context" );
}

{
  my ( $scalar ) = destructuring_bind '';
  is( $scalar, '', "Binding '' in list context" );
}

{
  my ( $scalar ) = destructuring_bind '0';
  is( $scalar, '0', "Binding '0' in list context" );
}

{
  my $scalar;
  $scalar = destructuring_bind 0;
  is( $scalar, 0, "Binding 0 in scalar context without 'my'" );
}

{
  my $scalar;
  $scalar = destructuring_bind 0.0;
  is( $scalar, 0.0, "Binding 0.0 in scalar context without 'my'" );
}

{
  my $scalar;
  $scalar = destructuring_bind '';
  is( $scalar, '', "Binding '' in scalar context without 'my'" );
}

{
  my $scalar;
  $scalar = destructuring_bind '0';
  is( $scalar, '0', "Binding '0' in scalar context without 'my'" );
}

{
  my $scalar;
  ( $scalar ) = destructuring_bind 0;
  is( $scalar, 0, "Binding 0 in list context without 'my'" );
}

{
  my $scalar;
  ( $scalar ) = destructuring_bind 0.0;
  is( $scalar, 0.0, "Binding 0.0 in list context without 'my'" );
}

{
  my $scalar;
  ( $scalar ) = destructuring_bind '';
  is( $scalar, '', "Binding '' in list context without 'my'" );
}

{
  my $scalar;
  ( $scalar ) = destructuring_bind '0';
  is( $scalar, '0', "Binding '0' in list context without 'my'" );
}
# }}}

# {{{ Binding true values to scalar binds
{
  my $scalar = destructuring_bind 27;
  is( $scalar, 27, "Binding 27 in scalar context" );
}

{
  my $scalar = destructuring_bind 'foo';
  is( $scalar, 'foo', "Binding 'foo' in scalar context" );
}

{
  my ( $scalar ) = destructuring_bind 27;
  is( $scalar, 27, "Binding 27 in list context" );
}

{
  my ( $scalar ) = destructuring_bind 'foo';
  is( $scalar, 'foo', "Binding 'foo' in list context" );
}

{
  my $scalar;
  $scalar = destructuring_bind 27;
  is( $scalar, 27, "Binding 27 in scalar context without 'my'" );
}

{
  my $scalar;
  $scalar = destructuring_bind 'foo';
  is( $scalar, 'foo', "Binding 'foo' in scalar context without 'my'" );
}

{
  my $scalar;
  ( $scalar ) = destructuring_bind 27;
  is( $scalar, 27, "Binding 27 in list context without 'my'" );
}

{
  my $scalar;
  ( $scalar ) = destructuring_bind 'foo';
  is( $scalar, 'foo', "Binding 'foo' in list context without 'my'" );
}
# }}}

# {{{ Binding references to scalar binds
{
  my $scalar = destructuring_bind [ ];
  is_deeply( $scalar, [ ], "Binding [ ] in scalar context" );
}

{
  my $scalar = destructuring_bind { };
  is_deeply( $scalar, { }, "Binding { } in scalar context" );
}

{
  my ( $scalar ) = destructuring_bind [ ];
  is_deeply( $scalar, [ ], "Binding [ ] in list context" );
}

{
  my ( $scalar ) = destructuring_bind { };
  is_deeply( $scalar, { }, "Binding { } in list context" );
}

{
  my $scalar;
  $scalar = destructuring_bind [ ];
  is_deeply( $scalar, [ ], "Binding [ ] in scalar context without 'my'" );
}

{
  my $scalar;
  $scalar = destructuring_bind { };
  is_deeply( $scalar, { }, "Binding { } in scalar context without 'my'" );
}

{
  my $scalar;
  ( $scalar ) = destructuring_bind [ ];
  is_deeply( $scalar, [ ], "Binding [ ] in list context without 'my'" );
}

{
  my $scalar;
  ( $scalar ) = destructuring_bind { };
  is_deeply( $scalar, { }, "Binding { } in list context without 'my'" );
}
# }}}

# {{{ Binding non-empty references to scalar binds
{
  my $scalar = destructuring_bind [ 27 ];
  is_deeply( $scalar, [ 27 ], "Binding [ 27 ] in scalar context" );
}

{
  my $scalar = destructuring_bind { foo => 27 };
  is_deeply(
     $scalar, { foo => 27 },
     "Binding { foo => 27 } in scalar context"
  );
}

{
  my ( $scalar ) = destructuring_bind [ 27 ];
  is_deeply( $scalar, [ 27 ], "Binding [ 27 ] in list context" );
}

{
  my ( $scalar ) = destructuring_bind { foo => 27 };
  is_deeply(
     $scalar, { foo => 27 },
     "Binding { foo => 27 } in list context"
  );
}

{
  my $scalar;
  $scalar = destructuring_bind [ 27 ];
  is_deeply( $scalar, [ 27 ], "Binding [ 27 ] in scalar context without 'my'" );
}

{
  my $scalar;
  $scalar = destructuring_bind { foo => 27 };
  is_deeply(
     $scalar, { foo => 27 },
     "Binding { foo => 27 } in scalar context without 'my'"
  );
}

{
  my $scalar;
  ( $scalar ) = destructuring_bind [ 27 ];
  is_deeply( $scalar, [ 27 ], "Binding [ 27 ] in list context without 'my'" );
}

{
  my $scalar;
  ( $scalar ) = destructuring_bind { foo => 27 };
  is_deeply(
     $scalar, { foo => 27 },
     "Binding { foo => 27 } in list context without 'my'"
  );
}
# }}}

=pod

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

=cut
