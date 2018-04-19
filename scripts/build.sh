#!/bin/bash
workDir="$GOPATH/src/github.com/uniontsai/platformapi"
source $workDir/contrib/scripts/constants.sh

echo "using $(go version)"
LDFLAGS="-w -s -X $release=$VERSION -X $commitSHA1=$lastCommitSHA1 -X '$commitTime=$lastCommitTime'"

# build multiplatform
echo "building $binFile/$VERSION darwin/amd64"
GOOS=darwin GOARCH=amd64 go build -ldflags "$LDFLAGS" -o $targetDir/$binFile.darwin.amd64 $sourceDir
echo "building $binFile/$VERSION windows/amd64"
GOOS=windows GOARCH=amd64 go build -ldflags "$LDFLAGS" -o $targetDir/$binFile.windows.amd64.exe $sourceDir
echo "building $binFile/$VERSION linux64/amd64"
GOOS=linux GOARCH=amd64 go build -ldflags "$LDFLAGS" -o $targetDir/$binFile.linux.amd64 $sourceDir