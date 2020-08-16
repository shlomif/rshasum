package App::rshasum;

use 5.016;
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
    my @prunes     = ( map { qr/$_/ } @{ $args->{prune_re} || [] } );
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
            my $fh;
            if ( not( open $fh, '<', $r->path ) )
            {
                warn "Could not open @{[$r->path]} ; skipping";
                next FILES;
            }
            binmode $fh;
            my $d = Digest->new($digest);
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
    ) or die "Unknown flags $!";
    if ( not defined($digest) )
    {
        die "Please give a --digest=[digest] argument.";
    }
    if (@ARGV)
    {
        die
qq#Leftover arguments "@ARGV" in the command line. (Did you intend to use --start-path ?)#;
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

=head1 DESCRIPTION

A recursive digest calculator that prints digests for all files
in a directory tree, as well as a total, summary, digest of the output.

=head1 FLAGS

=head2 --digest

The digest algorithm to use. Required. E.g:

    --digest=SHA-256
    --digest=SHA-512
    --digest=MD5

=head2 --skip

Perl 5 regexes which when matched against the relative paths,
skip and prune them.

Can be specified more than one time.

=head2 --start-path

The start path for the traversal. Defaults to "." (the
current working directory).

=head1 METHODS

=head2 run

Runs the app.

=head1 SEE ALSO

L<https://github.com/rhash/RHash> - "recursive hash". Seems to emit the
tree in an unpredictable, not-always-sorted, order.

L<https://www.shlomifish.org/open-source/projects/File-Dir-Dumper/> - also
on CPAN. Dumps metadata and supports caching the digests.

L<https://github.com/gokyle/rshasum> - written in golang, but slurps
entire files into memory (see L<https://github.com/gokyle/rshasum/issues/1> ).

=cut
