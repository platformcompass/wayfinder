package voyages

import (
	"tool/exec"
	"encoding/yaml"
	"encoding/json"
)

_objects: objects

// Export objects as YAML
command: vbuild: {
	task: print: {
		kind: "print"
		text: yaml.MarshalStream(_objects)
	}
}

// command: gen: {
// 	task: print: cli.Print & {
// 		text: yaml.MarshalStream([ for x in resources {x}])
// 	}
// }
