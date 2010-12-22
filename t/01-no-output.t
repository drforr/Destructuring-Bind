#!perl

use Test::More tests => 1;

BEGIN {
    use_ok( 'Destructuring::Bind' ) || print "Bail out!\n";
}

eval { destructuring_bind };
ok( ! $@, "Silent" );

eval { destructuring_bind 27 };
ok( ! $@, "Silent with scalar input" );

eval { destructuring_bind (27) x 100 };
ok( ! $@, "Silent with lots of scalar input" );

eval { destructuring_bind [ ] };
ok( ! $@, "Silent with empty arrayref input" );

eval { destructuring_bind [ 27 ] };
ok( ! $@, "Silent with arrayref input" );

eval { destructuring_bind [ (27) x 100 ] };
ok( ! $@, "Silent with large arrayref input" );

eval { destructuring_bind { } };
ok( ! $@, "Silent with empty hashref input" );

eval { destructuring_bind { a => 1 } };
ok( ! $@, "Silent with small hashref input" );

eval { destructuring_bind { (27, 'foo') x 100 } };
ok( ! $@, "Silent with large hashref input" );

eval { destructuring_bind bless {},'foo' };
ok( ! $@, "Silent with blessed empty object" );
