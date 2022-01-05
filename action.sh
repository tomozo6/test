#!/bin/bash

TAG_LATEST=$(git tag -l --sort=-v:refname | head -n 1)
echo "TAG_LATEST=${TAG_LATEST}"

TAG_PREVIOUS=$(git tag -l --sort=-v:refname | head -n 2 | tail -n 1)
echo "TAG_PREVIOUS=${TAG_PREVIOUS}"

# Header
RELEASE_NOTES="## What's Changed"

# Body
if [ ${TAG_PREVIOUS} ]; then
  BETWEEN_TAGS="${TAG_PREVIOUS}..${TAG_LATEST}"
else
  BETWEEN_TAGS="${TAG_LATEST}"
fi

IFS=$'\n'
for LINE in $(git log --oneline --decorate=no ${BETWEEN_TAGS})
do
  RELEASE_NOTES+="%0A- ${LINE}"
done

# Outputs
echo "::set-output name=release_notes::${RELEASE_NOTES}"