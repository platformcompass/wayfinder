package voyages

import "strings"

_objects: objects

command: vls: {
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
