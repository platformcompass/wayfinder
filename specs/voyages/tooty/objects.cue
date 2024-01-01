package voyages

import "github.com/bobmhong/wayfinder/pkg/voyage"

// Always set the name from the voyages key
#voyages: [ID=_]: voyage.#Voyage & {
	name: ID
}

// Combine all the generated objects
_objectSets: [
	#voyages,
]

// Create a list of all the objects
objects: [for v in _objectSets for x in v {x}]
