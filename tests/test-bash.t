#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;
use Test::Differences (qw( eq_or_diff ));
use IO::All qw/ io /;
use Cwd qw/ getcwd /;

{
    my $cwd = getcwd();
    system(qq%cd tests/data/1/ && "$cwd"/rshasum.bash > ../have1.txt%);

    # TEST
    eq_or_diff(
        io->file("tests/data/have1.txt")->all,
        io->file("tests/data/want1.txt")->all,
        "rshasum #1",
    );
}
{
    my $cwd = getcwd();
    system(
qq%cd tests/data/1/ && $^X "$cwd"/rshasum.pl --digest SHA-256 > ../have1.txt%
    );

    # TEST
    eq_or_diff(
        io->file("tests/data/have1.txt")->all,
        io->file("tests/data/want1.txt")->all,
        "rshasum #1",
    );
}
