#!/usr/bin/env bash
# Copyright 2023 The Kubernetes Authors.
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

set -o errexit
set -o nounset
set -o pipefail

ROOT_DIR=$(dirname "${BASH_SOURCE[0]}")/..

function update_ends_newline() {
  find . \( \
    -iname "*.md" \
    -o -iname "*.sh" \
    -o -iname "*.go" \
    -o -iname "*.tpl" \
    -o -iname "*.yaml" \
    -o -iname "*.yml" \
    \) \
    -not \( \
    -path ./.git/\* -o \
    -path ./vendor/\* -o \
    -path ./demo/node_modules/\* -o \
    -path ./site/themes/\* \
    \) \
    -exec sh -c '[ -n "$(tail -c 1 $1)" ] && echo >> $1' sh {} \;
}

cd "${ROOT_DIR}"

update_ends_newline || exit 1
