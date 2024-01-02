package main

import "strings"
import specs "github.com/platformcompass/wayfinder/specs/voyages:specs"

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
