package main

import (
	"strings"
	specs "github.com/bobmhong/wayfinder/specs"
)

_objects: specs.objects

command: ls: {
	task: print: {
		kind: "print"
		let Lines = [
			for k, v in _objects {
				"\(v.name)\t\(v.version)"
			},
		]
		text: strings.Join(Lines, "\n")
	}
}

// command: ls: {
// 	task: print: cli.Print & {
// 		text: tabwriter.Write([
// 			"RESOURCE \tAPI VERSION",
// 			for r in resources {
// 				if r.metadata.namespace == _|_ {
// 					"\(r.kind)/\(r.metadata.name) \t\(r.apiVersion)"
// 				}
// 				if r.metadata.namespace != _|_ {
// 					"\(r.kind)/\(r.metadata.namespace)/\(r.metadata.name)  \t\(r.apiVersion)"
// 				}
// 			},
// 		])
// 	}
// }
