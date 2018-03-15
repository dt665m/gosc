#!/bin/bash
set -e
binFile="uapi"
repo="github.com/uniontsai/platformapi"
sourceDir=$repo/$binFile
targetDir=$workDir/build
gitBranch=$(git rev-parse --abbrev-ref HEAD)
lastCommitSHA1=$(git rev-parse --short HEAD)
lastCommitTime=$(git log -1 --format=%ci)

release="github.com/uniontsai/platformapi/pkg/x.release"
branch="github.com/uniontsai/platformapi/pkg/x.gitBranch"
commitSHA1="github.com/uniontsai/platformapi/pkg/x.lastCommitSHA"
commitTime="github.com/uniontsai/platformapi/pkg/x.lastCommitTime"

# pull in variable configuration
set -o allexport
. $workDir/.env
set +o allexport