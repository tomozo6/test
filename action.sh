#!/bin/bash
TAG_LATEST=$(git tag --sort=-creatordate | sed -n 1p)
echo "TAG_LATEST=${TAG_LATEST}"
TAG_PREVIOUS=$(git tag --sort=-creatordate | sed -n 2p)
echo "TAG_PREVIOUS=${TAG_PREVIOUS}"

# Header
HEADER="## What's Changed"

# Body
if [ ${TAG_PREVIOUS} ]; then
  BETWEEN_TAGS="${TAG_PREVIOUS}..${TAG_LATEST}"
else
  BETWEEN_TAGS="${TAG_LATEST}"
fi

BODY=$(git log --oneline --pretty=tformat:"%s(%h)" ${BETWEEN_TAGS} | sort)
BODY="${BODY//$'\n'/'%0A'}"

# RELEASE_NOTES
RELEASE_NOTES="${HEADER}'%0A'${BODY}"
echo "::set-output name=release_notes::${RELEASE_NOTES}"





#IFS=$'\n'
#for LINE in $(git log --oneline --decorate=no ${BETWEEN_TAGS})
#do
#  RELEASE_NOTES+="%0A- ${LINE}"
#done

# Outputs
#echo "::set-output name=release_notes::${RELEASE_NOTES}"