package voyages

import (
	"github.com/platformcompass/wayfinder/pkg/release"
)

//*****************************************************************************//
// Chart Book - Configure all available charts and set global defaults         //
//*****************************************************************************//

#Podinfo: release.#Release & {
	spec: {
		voyagename:    _voyageName
		voyageversion: _voyageVersion
		name:          "podinfo"
		namespace:     "dev-apps"
		repository: {
			url: "https://stefanprodan.github.io/podinfo"
		}
		chart: {
			name: "podinfo"
		}
	}
}

#KomodorAgent: release.#Release & {
	spec: {
		voyagename:    _voyageName
		voyageversion: _voyageVersion
		name:          "komodor-agent"
		namespace:     "komodor"
		repository: {
			url: "https://helm-charts.komodor.io"
		}
		chart: {
			name:    "komodor-agent"
			version: *"2.1.0" | string
		}
	}
}

#KomodorAgent2: release.#Release & {
	spec: {
		voyagename:    _voyageName
		voyageversion: _voyageVersion
		name:          "komodor-agent2"
		namespace:     "komodor2"
		repository: {
			url: "https://helm-charts.komodor.io"
		}
		chart: {
			name:    "komodor-agent2"
			version: *"2.2.2" | string
		}
	}
}
