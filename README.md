# NAME

App::rshasum - recursive shasum.

# VERSION

version 0.6.4

# SYNOPSIS

    rshasum --digest=SHA-256
    rshasum --digest=SHA-256 --skip='\.sw[a-zA-Z]*\z' --skip='~\z'
    rshasum --digest=SHA-256 --start-path='/home/random-j-user'

# DESCRIPTION

A recursive digest calculator that prints digests for all files
in a directory tree, as well as a total, summary, digest of the output.

# FLAGS

## --digest

The digest algorithm to use. Required. E.g:

    --digest=SHA-256
    --digest=SHA-512
    --digest=MD5

## --skip

Perl 5 regexes which when matched against the relative paths,
skip and prune them.

Can be specified more than one time.

## --start-path

The start path for the traversal. Defaults to "." (the
current working directory).

# METHODS

## run

Runs the app.

# SEE ALSO

[https://github.com/rhash/RHash](https://github.com/rhash/RHash) - "recursive hash". Seems to emit the
tree in an unpredictable, not-always-sorted, order.

[https://www.shlomifish.org/open-source/projects/File-Dir-Dumper/](https://www.shlomifish.org/open-source/projects/File-Dir-Dumper/) - also
on CPAN. Dumps metadata and supports caching the digests.

[https://github.com/gokyle/rshasum](https://github.com/gokyle/rshasum) - written in golang, but slurps
entire files into memory (see [https://github.com/gokyle/rshasum/issues/1](https://github.com/gokyle/rshasum/issues/1) ).

# SUPPORT

## Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

- MetaCPAN

    A modern, open-source CPAN search engine, useful to view POD in HTML format.

    [https://metacpan.org/release/App-rshasum](https://metacpan.org/release/App-rshasum)

- RT: CPAN's Bug Tracker

    The RT ( Request Tracker ) website is the default bug/issue tracking system for CPAN.

    [https://rt.cpan.org/Public/Dist/Display.html?Name=App-rshasum](https://rt.cpan.org/Public/Dist/Display.html?Name=App-rshasum)

- CPANTS

    The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

    [http://cpants.cpanauthors.org/dist/App-rshasum](http://cpants.cpanauthors.org/dist/App-rshasum)

- CPAN Testers

    The CPAN Testers is a network of smoke testers who run automated tests on uploaded CPAN distributions.

    [http://www.cpantesters.org/distro/A/App-rshasum](http://www.cpantesters.org/distro/A/App-rshasum)

- CPAN Testers Matrix

    The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

    [http://matrix.cpantesters.org/?dist=App-rshasum](http://matrix.cpantesters.org/?dist=App-rshasum)

- CPAN Testers Dependencies

    The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

    [http://deps.cpantesters.org/?module=App::rshasum](http://deps.cpantesters.org/?module=App::rshasum)

## Bugs / Feature Requests

Please report any bugs or feature requests by email to `bug-app-rshasum at rt.cpan.org`, or through
the web interface at [https://rt.cpan.org/Public/Bug/Report.html?Queue=App-rshasum](https://rt.cpan.org/Public/Bug/Report.html?Queue=App-rshasum). You will be automatically notified of any
progress on the request by the system.

## Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

[https://github.com/shlomif/rshasum](https://github.com/shlomif/rshasum)

    git clone https://github.com/shlomif/rshasum.git

# AUTHOR

Shlomi Fish <shlomif@cpan.org>

# BUGS

Please report any bugs or feature requests on the bugtracker website
[https://github.com/shlomif/app-rshasum/issues](https://github.com/shlomif/app-rshasum/issues)

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2019 by Shlomi Fish.

This is free software, licensed under:

    The MIT (X11) License
