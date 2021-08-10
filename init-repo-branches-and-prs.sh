#!/usr/bin/env bash

set -eux


git init || true
gh repo create gh-actions-event-files --public -y

# git remote add origin git@github.com:blesson3/gh-actions-event-files.git || true

git checkout -b main || true
git add .
git commit -m "add workflow to save event files from workflow runs"
git push -u origin main

git checkout -b workflow-data
git push -u origin workflow-data

sleep 10

new_branch_with_pr()
{
  branchName="$1"

  git checkout main
  git checkout -b "$branchName"
  touch "${branchName}.txt"
  git add .
  git commit -m "new file"
  git push -u origin "$branchName"

  gh pr create --fill
}

new_branch_with_pr new-branch-1
sleep 10
new_branch_with_pr new-branch-2
sleep 10
new_branch_with_pr new-branch-3

sleep 10

git checkout workflow-data
