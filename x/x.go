package x

import (
	"fmt"
	"os"
	"runtime"
)

const (
	Docs        = "https://github.com/uniontsai/platformapi"
	Discussions = "https://uniontsai.slack.com"
)

var (
	// These variables are set using -ldflags
	version        string
	gitBranch      string
	lastCommitSHA  string
	lastCommitTime string
	goVersion      string
)

func BuildDetails() string {
	return fmt.Sprintf(`
Version          : %v
Commit SHA-1     : %v
Commit timestamp : %v
Branch           : %v
Go               : %v

For documentation, visit %v.
For discussions  , visit %v.
`,
		version, lastCommitSHA, lastCommitTime, gitBranch, runtime.Version())
}

func PrintVersionOnly() {
	fmt.Println(BuildDetails())
	os.Exit(0)
}

func Version() string {
	return version
}
