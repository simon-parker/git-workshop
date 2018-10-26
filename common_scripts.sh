#!/bin/bash

function clean_up() {
  rm -rf .git
  git init --quiet
  echo init > .gitignore
  echo INSTRUCTIONS.md >> .gitignore
  git add .gitignore
  git commit --quiet -m "initial commit";
  git clean -df --quiet
}

function commit() {
  echo "$1" >>foo
  git add .
  git commit --quiet --message "$1"
}

function branch() {
  git checkout -b "$1" 2>/dev/null || git checkout --quiet "$1"
}
