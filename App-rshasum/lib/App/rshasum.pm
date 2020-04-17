package App::rshasum;

use strict;
use warnings;

use File::Find::Object ();
use Digest             ();

use Getopt::Long qw/ GetOptions /;
use List::Util 1.33 qw/ any /;

sub _worker
{
    my ( $self, $args ) = @_;

    my $digest     = $args->{digest};
    my $output_cb  = $args->{output_cb};
    my @prunes     = @{ $args->{prune_re} || [] };
    my $start_path = ( $args->{start_path} // "." );

    my $t = Digest->new($digest);

    my $ff = File::Find::Object->new( {}, $start_path );
FILES:
    while ( my $r = $ff->next_obj )
    {
        my $path = join '/', @{ $r->full_components };
        if (@prunes)
        {
            if ( any { $path =~ $_ } @prunes )
            {
                $ff->prune;
                next FILES;
            }
        }
        if ( $r->is_file )
        {
            my $d = Digest->new($digest);
            open my $fh, '<', $r->path;
            binmode $fh;
            $d->addfile($fh);
            close $fh;
            my $s = $d->hexdigest . '  ' . $path . "\n";
            $output_cb->( { str => $s } );
            $t->add($s);
        }
    }
    my $s = $t->hexdigest . '  ' . "-" . "\n";
    $output_cb->( { str => $s } );

    return;
}

sub run
{
    my $digest;
    my @skips;
    my $start_path = '.';
    GetOptions(
        'digest=s'     => \$digest,
        'skip=s'       => \@skips,
        'start-path=s' => \$start_path,
    ) or die "foo $!";
    if ( not defined($digest) )
    {
        die "Please give a --digest=[digest] argument.";
    }
    return shift()->_worker(
        {
            digest     => $digest,
            output_cb  => sub { print shift()->{str}; },
            prune_re   => ( \@skips ),
            start_path => $start_path,
        }
    );
}

1;

=head1 NAME

App::rshasum - recursive shasum.

=head1 SYNOPSIS

    rshasum --digest=SHA-256
    rshasum --digest=SHA-256 --skip='\.sw[a-zA-Z]*\z' --skip='~\z'
    rshasum --digest=SHA-256 --start-path='/home/random-j-user'

=head1 METHODS

=head2 run

Runs the app.

=cut
