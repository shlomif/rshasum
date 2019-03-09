package App::rshasum;

use strict;
use warnings;

use File::Find::Object ();
use Digest             ();

use Getopt::Long qw/ GetOptions /;

sub run
{
    my $digest;
    GetOptions( 'digest=s' => \$digest, )
        or die "foo $!";
    if ( not defined($digest) )
    {
        die "Please give a --digest=[digest] argument.";
    }

    my $t = Digest->new($digest);

    my $ff = File::Find::Object->new( {}, "." );
    while ( my $r = $ff->next_obj )
    {
        if ( $r->is_file )
        {
            my $d    = Digest->new($digest);
            my $path = $r->path;
            open my $fh, '<', $path;
            binmode $fh;
            $d->addfile($fh);
            close $fh;
            my $s = $d->hexdigest . '  ' . $path . "\n";
            print $s;
            $t->add($s);
        }
    }
    my $s = $t->hexdigest . '  ' . "-" . "\n";
    print $s;
}

1;

=head1 NAME

App::rshasum - recursive shasum.

=head1 SYNOPSIS

    rshasum --digest=SHA-256

=head1 METHODS

=head2 run

Runs the app.

=cut
