#!/bin/bash
export SUM="${RSHASUM_SUM:-sha256sum}"
tfn="`mktemp`"
find . -type f -follow | (LC_ALL=C sort) | xargs -d '\n' "$SUM" | tee "$tfn"
"$SUM" - < "$tfn"
rm -f "$tfn"
