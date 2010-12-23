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

# {{{ Binding undef to scalar
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

# {{{ Binding false values to scalar
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

# {{{ Binding true values to scalar
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

# {{{ Binding references to scalar
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

# {{{ Binding non-empty references to scalar
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

# {{{ Binding N values to one scalar maps only the first
{
  my $scalar = destructuring_bind 27, 42;
  is( $scalar, 27, "Binding two values in scalar context gets the first only" );
}

{
  my ( $scalar ) = destructuring_bind 27, 42;
  is( $scalar, 27, "Binding two values in list context gets the first only" );
}

{
  my $scalar;
  $scalar = destructuring_bind 27, 42;
  is(
    $scalar, 27,
    "Binding two values in scalar context without 'my' gets the first only"
  );
}

{
  my $scalar;
  ( $scalar ) = destructuring_bind 27;
  is(
    $scalar, 27,
    "Binding two values in list context without 'my' gets the first only"
  );
}
# }}}

# {{{ Binding true value to array slice
{
  my $array[0] = destructuring_bind 27;
  is( $array[0], 27, "Binding 27 in scalar context" );
}

{
  my ( $array[0] ) = destructuring_bind 27;
  is( $array[0], 27, "Binding 27 in list context" );
}

{
  my @array = ( 1, 2 );
  $array[0] = destructuring_bind 27;
  is_deeply(
    \@array,
    [ 27, 2 ],
    "Binding 27 to array slice in scalar context without 'my'"
  );
}

{
  my @array = ( 1, 2 );
  ( $array[0] ) = destructuring_bind 27;
  is_deeply(
    \@array,
    [ 27, 2 ],
    "Binding 27 to array slice in list context without 'my'"
  );
}
# }}}

# {{{ Binding true value to hash slice
{
  my $hash{foo} = destructuring_bind 27;
  is( $hash{foo}, 27, "Binding 27 to hash slice in scalar context" );
}

{
  my ( $hash{foo} ) = destructuring_bind 27;
  is( $hash{foo}, 27, "Binding 27 to hash slice in list context" );
}

{
  my %hash = ( foo => 1, bar => 2 );
  $hash{foo} = destructuring_bind 27;
  is_deeply(
    \%hash,
    { foo => 27, bar => 2 },
    "Binding 27 to hash slice in scalar context without 'my'"
  );
}

{
  my %hash = ( foo => 1, bar => 2 );
  ( $hash{foo} ) = destructuring_bind 27;
  is_deeply(
    \%hash,
    { foo => 27, bar => 2 },
    "Binding 27 to hash slice in list context without 'my'"
  );
}
# }}}

# {{{ Binding true value to arrayref slice
{
  my $arrayref->[0] = destructuring_bind 27;
  is( $arrayref->[0], 27, "Binding 27 to arrayref slice in scalar context" );
}

{
  my ( $arrayref->[0] ) = destructuring_bind 27;
  is( $arrayref->[0], 27, "Binding 27 to arrayref slice in list context" );
}

{
  my $arrayref = [ 1, 2 ];
  $arrayref->[0] = destructuring_bind 27;
  is_deeply(
    $arrayref,
    [ 27, 2 ],
    "Binding 27 to arrayref slice in scalar context without 'my'"
  );
}

{
  my $arrayref = [ 1, 2 ];
  ( $arrayref->[0] ) = destructuring_bind 27;
  is_deeply(
    $arrayref,
    [ 27, 2 ],
    "Binding 27 to arrayref slice in list context without 'my'"
  );
}
# }}}

# {{{ Binding true value to hashref slice
{
  my $hashref->{foo} = destructuring_bind 27;
  is( $hashref->{foo}, 27, "Binding 27 to hashref slice in scalar context" );
}

{
  my ( $hashref->{foo} ) = destructuring_bind 27;
  is( $hashref->{foo}, 27, "Binding 27 to hashref slice in list context" );
}

{
  my $hashref = { foo => 1, bar => 2 };
  $hashref->{foo} = destructuring_bind 27;
  is_deeply(
    $hashref,
    { foo => 27, bar => 2 },
    "Binding 27 to hashref slice in scalar context without 'my'"
  );
}

{
  my $hash = { foo => 1, bar => 2 };
  ( $hashref->{foo} ) = destructuring_bind 27;
  is_deeply(
    $hashref,
    { foo => 27, bar => 2 },
    "Binding 27 to hashref slice in list context without 'my'"
  );
}
# }}}
