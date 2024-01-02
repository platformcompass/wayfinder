package main

import (
	"tool/exec"
	"encoding/yaml"
	"encoding/json"
	//"github.com/platformcompass/wayfinder/pkg/voyage"
	"github.com/platformcompass/wayfinder/specs"
)

_objects: specs.objects

// Export objects as YAML
command: build: {
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
