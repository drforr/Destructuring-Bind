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

    $bind_me = [ { text => q{Hello world} }, "Stuff" ];
    ( $text, $description ) =
      destructuring_bind $bind_me;
    

=head1 EXPORT

=head2 destructuring_bind

The core and only notable "function" exported by this module. It performs the
rough equivalent of the (destructuring-bind) macro on a Perl data structure.

In general it can be thought of as the list assignment operator on steroids.

For example, a common way to "unpack" function arguments looks like this:

  sub print_name {
    my ( $self, $name ) = @_;
    print $name->{given} . ' ' . $name->{surname};
  }
  $self->print_name({ given => 'Jane', surname => 'Doe' }); # "Jane Doe"

Destructuring-bind allows you to look deeper into the argument list. For
instance, you're really only interested in the surname and given name in that
particular method, so destructuring-bind lets you write this:

  sub print_name {
    my ( $self, { given => $given, surname => $surname } ) =
      destructuring_bind @_;
    print $given . ' ' . $surname;
  }
  $self->print_name({ given => 'Jane', surname => 'Doe' }); # "Jane Doe"

To this end, the module accepts everything that can normally be found on the
LHS of a list assignment, and lots of things that normally wouldn't be allowed.

=head2 Bindings

Straightforward list assignment still works:

  ( $foo, $bar, $baz ) = destructuring_bind 1, 2, 3; # $foo = 1, etc.

Adding undef's skips unwanted entries:

  ( $foo, undef, $baz ) = destructuring_bind 1, 2, 3; # $baz = 3

Assignment to a list is still unchanged:

  @foo = destructuring_bind 1, 2, 3; # @foo = ( 1, 2, 3 )

And lists still swallow the rest of the input:

  ( @foo, $bar ) = destructuring_bind 1, 2; # @foo = ( 1, 2 ); $bar = undef

But you can assign to list elements:

  ( $foo[0], $bar ) = destructuring_bind 1, 2; # @foo = ( 1 ); $bar = 2

And list slices:

  ( @foo[0,1], $bar ) = destructuring_bind 1, 2, 3; # @foo = ( 1, 2 ); $bar = 3

  ( @foo[1..3], $bar ) = destructuring_bind 1..4;
  # @foo = ( undef, 1, 2, 3 ); $bar = 4

List slices can run to the end of the list:

  ( @foo[2..-1], $bar ) = destructuring_bind 1, 2, 3;
  # @foo = ( undef, undef, 1, 2, 3 ); $bar = undef

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
