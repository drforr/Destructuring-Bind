use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Destructuring::Bind',
    AUTHOR              => q{Jeff Goff <jgoff@cpan.org>},
    VERSION_FROM        => 'lib/Destructuring/Bind.pm',
    ABSTRACT_FROM       => 'lib/Destructuring/Bind.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Destructuring-Bind-*' },
);
