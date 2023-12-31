package voyages

import (
    "github.com/bobmhong/wayfinder/pkg/voyage"
	"github.com/bobmhong/wayfinder/pkg/release"
)

_voyageName: "minnow"
_voyageVersion: "2.0.0"

#voyages: _voyageName: voyage.#Voyage & {
    // override the version for this instance
    version: _voyageVersion
}

// Environment defines the destination cluster.
env: *"production" | string @tag(env,short=staging|production)

// Releases holds the list of releases per env.
releases: [...release.#Release]

// Podinfo base definition.
#Podinfo: release.#Release & {
	spec: {
		voyagename: _voyageName
		voyageversion: _voyageVersion
		name:      "podinfo"
		namespace: "dev-apps"
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
		voyagename: _voyageName
		voyageversion: _voyageVersion
		name:      "komodor-agent"
		namespace: "komodor"
		repository: {
			url: "https://helm-charts.komodor.io"
		}
		chart: {
			name: "komodor-agent"
			version: "2.1.0"
		}
	}
}