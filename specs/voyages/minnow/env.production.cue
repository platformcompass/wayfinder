@if(production)
package voyages

// Releases included in this cluster.
releases: [podinfo, KomodorAgent, KomodorAgent2]

podinfo: #Podinfo & {
	spec: {
		serviceAccountName: "flux-apps"
		chart: version: "6.0.x"
		values: {
			hpa: {
				enabled:     true
				maxReplicas: 10
				cpu:         99
			}
			resources: {
				limits: memory: "512Mi"
				requests: {
					cpu:    "100m"
					memory: "32Mi"
				}
			}
		}
	}
}

KomodorAgent: #KomodorAgent & {
	spec: {
		serviceAccountName: "komodor"
		chart: version: "2.1.0"
		values: {
			apiKey: "12345"
		}
	}
}

KomodorAgent2: #KomodorAgent2 & {
	spec: {
		serviceAccountName: "komodor"
		chart: version: "2.2.3"
		values: {
			apiKey: "12345"
		}
	}
}
