#!/bin/bash

TMP_CLONE_FOLDER="tmp_wiki"

if [ -z "$ACTION_MAIL" ]; then
  echo "ACTION_MAIL ENV is missing. Quitting."
  exit 1
fi

if [ -z "$ACTION_NAME" ]; then
  echo "ACTION_NAME ENV is missing. Quitting."
  exit 1
fi

if [ -z "$OWNER" ]; then
  echo "OWNER ENV is missing. Quitting."
  exit 1
fi

if [ -z "$REPO_NAME" ]; then
  echo "REPO_NAME ENV is missing. Quitting."
  exit 1
fi

if [ -z "$MD_FOLDER" ]; then
  echo "MD_FOLDER ENV is missing. Quitting."
  MD_FOLDER='.'
fi

mkdir $TMP_CLONE_FOLDER
cd $TMP_CLONE_FOLDER
git init
git config user.name $ACTION_NAME
git config user.email $ACTION_MAIL
git pull https://${GH_PAT}@github.com/$OWNER/$REPO_NAME.wiki.git
cd ..

find $MD_FOLDER -type f | grep -i md$ | xargs -i cp {} $TMP_CLONE_FOLDER

echo "Pushing Wiki Pages"
cd $TMP_CLONE_FOLDER
git add .
git commit -m "Pushing Wiki Pages"
git push --set-upstream https://${GH_PAT}@github.com/$OWNER/$REPO_NAME.wiki.git master