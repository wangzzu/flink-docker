#!/bin/bash -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

. "${SCRIPT_DIR}/testing_lib.sh"

IS_PULL_REQUEST=
if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
  IS_PULL_REQUEST=1
fi

BRANCH="$TRAVIS_BRANCH"

./add-version.sh -r 1.9 -f 1.9.3

if [ -z "$IS_PULL_REQUEST" ] && [ "$BRANCH" = "dev-1.9" ]; then
  smoke_test_all_images
  smoke_test_one_image_non_root
else
  # For pull requests and branches, test one image
  smoke_test_one_image
fi

# vim: et ts=2 sw=2