package voyages

import (
    "github.com/bobmhong/wayfinder/pkg/voyage"
	"github.com/bobmhong/wayfinder/pkg/release"
)

_voyageName: *"undecided" | string
_voyageVersion: *"0.0.0" | string

#voyages: _voyageName: voyage.#Voyage & {
    // override the version for this instance
    version: _voyageVersion
}

// Environment defines the destination cluster.
env: *"production" | string @tag(env,short=staging|production)

// Releases holds the list of releases per env.
releases: [...release.#Release]