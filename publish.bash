#!/bin/bash

set -e

HERE=$(cd $(dirname $0); pwd)
rm -rf ${HERE}/book
git clone git@github.com:glop-rs/glop-rs.github.io publish

workdir=$(mktemp -d)
trap "rm -rf $workdir" EXIT

mv publish/.git ${workdir}

mdbook build -d publish
mv ${workdir}/.git publish

(cd publish; git add --all; git commit -m "Publish $(date +%Y%m%d%H%M%S)"; git push origin master)

