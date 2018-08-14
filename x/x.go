package x

import (
	"fmt"
	"os"
)

var (
	// These variables are set using -ldflags
	name           string
	version        string
	gitBranch      string
	lastCommitSHA  string
	lastCommitTime string
	build          string
)

func BuildDetails() string {
	return fmt.Sprintf(`
Name             : %v
Release          : %v
Commit SHA1      : %v
Commit Timestamp : %v
Branch           : %v
Build            : %v
`,
		name, version, lastCommitSHA, lastCommitTime, gitBranch, build)
}

func PrintVersionOnly() {
	fmt.Println(BuildDetails())
	os.Exit(0)
}

func Version() string {
	return version
}
