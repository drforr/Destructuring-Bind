package Destructuring::Bind;

use warnings;
use strict;

=head1 NAME

Destructuring::Bind - The great new Destructuring::Bind!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Emulates what we can of Lisp's (destructuring-bind) in Perl.

    use Destructuring::Bind qw( destructuring_bind );

    sub print_name {
      my ( $self, { given => $given, family => $family } ) =
        destructuring_bind @_;
      say "$given $family";
    }
    $obj->print_name( { given => "Jane", family => "Doe" } );
    

=head1 EXPORT

=head2 destructuring_bind

This is more of a syntax extension than a function. On its RHS it accepts an arbitrarily complex data structure, and on the LHS it accepts a list of Perl variables, in arbitrarily nested anonymous data structures.

That's a really vague and generic description, so let's work with a concrete example. Suppose you're dealing with an employee record that looks like this:

  $employee = {
    name => {
      given => 'Jane',
      family => 'Doe'
    },
    salary => 75_000
  };

A simple method to print an employee's salary could look like this:

  sub print_salary {
    my ( $self, $emp ) = @_;
    say "$emp->{name}{given} $emp->{name}{family}: $emp->{salary}";
  }

Or you could extract the name and salary, then print it:

  sub print_salary {
    my ( $self, $emp ) = @_;
    my ( $given, $family, $salary ) = (
      $emp->{name}{given},
      $emp->{name}{family},
      $emp->{salary}
    );
    say "$given $family: $salary";
  }

But that's pretty inelegant. Hash slices are one solution, but wouldn't it be nice if you could do something like:

  sub print_salary {
    my ( $self,
         { name =>
           { given => $given,
             family => $family },
           salary => $salary } ) = destructuring_bind @_;
    say "$given $family: $salary";
  }

And just capture all of the variables in one operation? That's what C<destructuring_bind> is meant to be used for.

=cut

=head1 AUTHOR

Jeff Goff, C<< <jgoff at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-destructuring-bind at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Destructuring-Bind>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Destructuring::Bind


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Destructuring-Bind>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Destructuring-Bind>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Destructuring-Bind>

=item * Search CPAN

L<http://search.cpan.org/dist/Destructuring-Bind/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Jeff Goff.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Destructuring::Bind
