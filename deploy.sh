#!/bin/bash

set -e

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git config --global push.default simple

rm -rf deployment
git clone -b master https://github.com/mryqu/mryqu.github.io deployment
rsync -av --delete --exclude ".git" public/ deployment
cd deployment
git add -A
# we need the || true, as sometimes you do not have any content changes
# and git woundn't commit and you don't want to break the CI because of that
git commit -m "rebuilding site on `date`, commit ${TRAVIS_COMMIT} and job ${TRAVIS_JOB_NUMBER}" || true
git push

cd ..
rm -rf deployment
