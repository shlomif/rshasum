#!/bin/bash
#
# Copyright (C) 2018 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under the terms of the ISC license.
#

export SUM="${RSHASUM_SUM:-sha256sum}"
tfn="`mktemp`"
find . -type f -follow | (LC_ALL=C sort) | xargs -d '\n' "$SUM" | tee "$tfn"
"$SUM" - < "$tfn"
rm -f "$tfn"
