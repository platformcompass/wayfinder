package specs

import "github.com/bobmhong/wayfinder/pkg/voyage"

#voyages: minnow: voyage.#Voyage & {
    // override the version for this instance
    version: "2.0.0"
}
