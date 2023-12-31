package voyages

import (
	"github.com/bobmhong/wayfinder/pkg/release"
)

// Environment defines the destination cluster.
env: *"" | string @tag(env,short=staging|production)

// Releases holds the list of releases per env.
releases: [...release.#Release]

// Podinfo base definition.
#Podinfo: release.#Release & {
	spec: {
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
