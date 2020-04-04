#!/bin/bash

unalias git 2> /dev/null

if [ $? -eq 0 ]
then
  echo 'You have a bash alias for `git`'
  echo '(possibly due to a tool like git-together)'
  echo 'We are removing it for this session'
  echo 'You can start a new terminal to get it back'
  echo
fi

function clean_up() {
  rm -rf .git
  git init --quiet
  echo init > .gitignore
  echo INSTRUCTIONS.md >> .gitignore
  echo "remote" >> .gitignore
  git add .gitignore
  git commit --quiet -m "initial commit";
  git clean -df --quiet

  rm -rf "remote"
  mkdir "remote"
  # shellcheck disable=SC2164
  pushd "remote" > /dev/null
    git init --bare --quiet;
  # shellcheck disable=SC2164
  popd > /dev/null

  git remote add origin "remote"
}

function commit() {
  echo "$1" >>foo
  git add .
  git commit --quiet --message "$1"
}

function branch() {
  git checkout -b "$1" 2>/dev/null || git checkout --quiet "$1"
}

function push() {
  git push --quiet origin head
}
