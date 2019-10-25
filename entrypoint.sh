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

if [ ! -z "$SKIP_MD" ]; then
  DOC_TO_SKIP=(`echo $SKIP_MD | sed s/,/\ /g`)
else
  DOC_TO_SKIP=
fi

mkdir $TMP_CLONE_FOLDER
cd $TMP_CLONE_FOLDER
git init
git config user.name $ACTION_NAME
git config user.email $ACTION_MAIL
git pull https://${GH_PAT}@github.com/$OWNER/$REPO_NAME.wiki.git
cd ..

for i in $(find $MD_FOLDER -maxdepth 3 -type f -name '*.md' -execdir basename '{}' ';'); do
    echo $i
    if [[ ! " ${DOC_TO_SKIP[@]} " =~ " ${i} " ]]; then
        cp $MD_FOLDER/$i $TMP_CLONE_FOLDER
    else
        echo "Skipping $i as it matches the $SKIP_MD rule"
    fi
done

echo "Pushing new pages"
cd $TMP_CLONE_FOLDER
git add .
git commit -m "$WIKI_PUSH_MESSAGE"
git push --set-upstream https://${GH_PAT}@github.com/$OWNER/$REPO_NAME.wiki.git master