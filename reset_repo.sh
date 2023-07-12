#!/bin/bash
git reset --hard

git checkout root
git fetch
git reset --hard origin/root

git branch | grep -v "root" | xargs git push origin --delete
git branch | grep -v "root" | xargs git branch -D

git switch -c master
git reset --hard root

echo "# Sample yml file content" > config.yml
git add config.yml
git commit -m "commit 1"
sleep 1

mkdir src
echo "\"Sample json file content\"" > src/index.json
git add src/index.json
git commit -m "commit 2"
sleep 1

git switch -c feature
git reset --hard master

echo "// Sample typescript file content" > src/index.ts
echo "// Sample javascript file content" > src/index.js
git add src/index.ts src/index.js
git commit -m "feature 1"
sleep 1

git switch master
echo "# Sample ruby file content" > src/index.rb
git add src/index.rb
git commit -m "commit 3"

git push --force --all

git reset --hard HEAD~
cp .git/refs/heads/master .git/refs/remotes/origin/master
git branch --set-upstream-to=origin/master master
