#!/usr/bin/env perl
#
# Copyright (C) 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under the terms of the ISC license.
#
#
use strict;
use warnings;

use File::Find::Object ();
use Digest             ();

use Getopt::Long qw/ GetOptions /;

my $digest;
GetOptions( 'digest=s' => \$digest, )
    or die "foo $!";

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
