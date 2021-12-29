#!/bin/bash

echo "## What's Changed" > release-notes.md

git log --oneline --decorate=no v0.0.15..v0.0.16 | while read line ; do echo "- ${line}" >> release-notes.md ; done

cat release-notes.md

