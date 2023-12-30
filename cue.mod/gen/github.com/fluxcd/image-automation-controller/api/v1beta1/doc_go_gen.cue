// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/image-automation-controller/api/v1beta1

// Package v1beta1 contains API types for the image API group, version
// v1beta1. The types here are concerned with automated updates to
// git, based on metadata from OCI image registries gathered by the
// image-reflector-controller. v1alpha2 did some rearrangement from
// v1alpha1 to make room for future enhancements; v1beta1 does not
// change the schema from v1alpha2.
//
// +kubebuilder:object:generate=true
// +groupName=image.toolkit.fluxcd.io
package v1beta1