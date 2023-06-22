#!/bin/bash -xe

# Copyright 2021 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

VERSION="${1}"

if [[ ! "${VERSION}" =~ ^(v[0-9]+[.][0-9]+)[.]([0-9]+)(-(alpha|beta|rc)[.]([0-9]+))?$ ]]; then
  echo "Version ${VERSION} must be 'vX.Y.Z', 'vX.Y.Z-alpha.N', 'vX.Y.Z-beta.N', or 'X.Y.Z-rc.N'"
  exit 1
fi

MINOR=${BASH_REMATCH[1]}
RELEASE_BRANCH="release-${MINOR}"

if [ "$(git tag -l "v${VERSION}")" ]; then
  echo "Tag v${VERSION} already exists"
  exit 0
fi

git tag -s -a ${VERSION} -m ${VERSION}
git tag test/${VERSION}

git push origin ${VERSION}
git push origin test/${VERSION}