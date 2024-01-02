package main

import (
	"strings"
	"list"
	"tool/cli"
	"tool/exec"
	"tool/file"
)

sops: marker: "\"data\": \"ENC["

// The seal command encrypts with SOPS all CUE files  with the extension '.secrets.cue'.
command: seal: {
	gitRoot: exec.Run & {
		cmd: ["git", "rev-parse", "--show-toplevel"]
		stdout: string
		path:   strings.TrimSpace(stdout)
	}
	printRoot:
		print: cli.Print & {
			text: "gitRoot \(gitRoot.path)"
		}
	list: file.Glob & {
		glob: "\(gitRoot.path)/specs/*.secrets.cue"
	}
	print: cli.Print & {
		text: "Checking \(len(list.files)) file(s)"
	}
	for _, filepath in list.files {
		(filepath): {
			secret: file.Read & {
				filename: filepath
				contents: string
			}
			if !strings.Contains(secret.contents, sops.marker) {
				print: cli.Print & {
					text: "seal \(filepath)"
				}
				sops: exec.Run & {
					$after: print
					cmd: ["sops", "-e", "-i", filepath]
				}
			}
		}
	}
}

// The unseal command decrypts with SOPS all CUE files with the extension '.secrets.cue'.
command: unseal: {
	gitRoot: exec.Run & {
		cmd: ["git", "rev-parse", "--show-toplevel"]
		stdout: string
		path:   strings.TrimSpace(stdout)
	}
	list: file.Glob & {
		glob: "\(gitRoot.path)/specs/*.secrets.cue"
	}
	// encryptlist: file.Glob & {
	// 	glob: "\(gitRoot.path)/**/**/*.encrypted"
	// }
	//biglist: list.concat(list.files, encryptlist.files) - this is not working
	for _, filepath in list.files {
		(filepath): {
			secret: file.Read & {
				filename: filepath
				contents: string
			}
			if strings.Contains(secret.contents, sops.marker) {
				print: cli.Print & {
					text: "unseal \(filepath)"
				}
				sops: exec.Run & {
					$after: print
					cmd: ["sops", "-d", "-i", filepath]
				}
			}
		}
	}
}
