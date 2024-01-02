package voyage

#Voyage: {
    name: string
    apiVersion: "wayfinder.platformcompass.org/v1beta1"
	kind:       "Voyage"
	version:     *"0.1.0" | string
	namespace:  *"wayfinder" | string
	let Name=name
	let Namespace=namespace
	metadata: {
		name:        Name
		namespace:   Namespace
		labels:      "voyage.wayfinder.platformcompass.org/name": Name
		annotations: "voyage.wayfinder.platformcompass.org/version": version
	}
}
