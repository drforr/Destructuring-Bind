#!perl

use Test::More tests => 1;

BEGIN {
    use_ok( 'Destructuring::Bind' ) || print "Bail out!\n";
}

eval { destructuring_bind };
ok( ! $@, "Bare call is a no-op" );

eval { destructuring_bind 27 };
ok( ! $@, "Bare call with scalar is a no-op" );

eval { destructuring_bind (27) x 100 };
ok( ! $@, "Bare call with *lots* of scalars is a no-op" );

eval { destructuring_bind [ ] };
ok( ! $@, "Bare call with empty arrayref is a no-op" );

eval { destructuring_bind [ 27 ] };
ok( ! $@, "Bare call with arrayref is a no-op" );

eval { destructuring_bind [ (27) x 100 ] };
ok( ! $@, "Bare call with large arrayref is a no-op" );

eval { destructuring_bind { } };
ok( ! $@, "Bare call with empty hashref is a no-op" );

eval { destructuring_bind { a => 1 } };
ok( ! $@, "Bare call with small hashref is a no-op" );

eval { destructuring_bind { (27, 'foo') x 100 } };
ok( ! $@, "Bare call with large hashref is a no-op" );

eval { destructuring_bind bless {},'foo' };
ok( ! $@, "Bare call with blessed hash is a no-op" );
