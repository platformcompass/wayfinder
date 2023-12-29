package voyage

#Voyage: {
    name: string
    apiVersion: "wayfinder.bobmhong.github.com/v1beta1"
	kind:       "Voyage"
	version:     *"0.1.0" | string
	namespace:  *"wayfinder" | string
	let Name=name
	let Namespace=namespace
	metadata: {
		name:        Name
		namespace:   Namespace
		labels:      "voyage.wayfinder.bobmhong.github.com/name": Name
		annotations: "voyage.wayfinder.bobmhong.github.com/version": version
	}
}

// Always set the name from the voyages key
#voyages: [ID=_]: #Voyage & {
    name: ID
}

// Combine all the generated objects
_objectSets: [
#voyages
]

// Create a list of all the objects
objects: [ for v in _objectSets for x in v { x } ]