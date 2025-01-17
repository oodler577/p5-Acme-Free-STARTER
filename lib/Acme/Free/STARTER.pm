package Acme::Free::STARTER;

use v5.10;
use strict;
use warnings;

our $VERSION = '1.0.0';

use HTTP::Tiny;
use JSON            qw/decode_json/;
use Util::H2O::More qw/baptise ddd HTTPTiny2h2o h2o/;

use constant {
    BASEURL => "https://...",
};

sub new {
    my $pkg  = shift;
    my $self = baptise { ua => HTTP::Tiny->new }, $pkg;
    return $self;
}

# used by: bin/fletch random [--breed BREED]
sub random {
    my $self   = shift;
    my $params = h2o {@_}, qw/breed/;

    #  https://dog.ceo/api/breeds/image/random Fetch!
    my $URL    = sprintf "%s/breeds/image/random", BASEURL;

    # handle optional, 'breed => BREED'
    if ($params->breed) {
      # https://dog.ceo/api/breed/affenpinscher/images/random 
      $URL    = sprintf "%s/breed/%s/images/random", BASEURL, lc $params->breed;
    }

    my $resp   = HTTPTiny2h2o $self->ua->get($URL);
    die sprintf( "fatal: API did not provide a useful response (status: %d)\n", $resp->status ) if ( $resp->status != 200 );

    return $resp->content->message;
}

1;

__END__

=head1 NAME

Acme::Free::STARTER - Perl API client for the REPLACE API service, L<https:// ...>.

This module provides the client, "REPLACE", that is available via C<PATH> after install.

=head1 SYNOPSIS

  #!/usr/bin/env perl
    
  use strict;
  use warnings;
  
  use Acme::Free::STARTER qw//;
  
  my $client = Acme::Free::STARTER->new;

  printf "%s\n", $client->REPLACEME;

=head2 C<REPLACE> Commandline Client

After installing this module, simply run the command C<fletch> without any argum
ents to get a URL for a random dog image. See below for all subcommands.

  shell> REPLACE 
  ..replace this
  shell>

=head1 DESCRIPTION

This is the Perl API for the REPLACE API, profiled at L<https://www.freepublicapis.com/REPLACE>. 

Contributed as part of the B<FreePublicPerlAPIs> Project described at,
L<https://github.com/oodler577/FreePublicPerlAPIs>.

This fun module is to demonstrate how to use L<Util::H2O::More> and
L<Dispatch::Fu> to make creating easily make API SaaS modules and
clients in a clean and idiomatic way. These kind of APIs tracked at
L<https://www.freepublicapis.com/> are really nice for fun and practice
because they don't require dealing with API keys in the vast majority of cases.

This module is the first one written using L<Util::H2O::More>'s C<HTTPTiny2h2o>
method that looks for C<JSON> in the C<content> key returned via L<HTTP::Tiny>'s
response C<HASH>.

=head1 METHODS

=over 4

=item C<new>

Instantiates object reference. No parameters are accepted.

=back

=head1 C<fletch> OPTIONS

=over 4

=item C<REPLACE --??? XYZ>

=back

=head2 Internal Methods

There are no internal methods to speak of.

=head1 ENVIRONMENT

Nothing special required.

=head1 AUTHOR

Brett Estrade L<< <oodler@cpan.org> >>

=head1 BUGS

Please report.

=head1 LICENSE AND COPYRIGHT

Same as Perl/perl.
