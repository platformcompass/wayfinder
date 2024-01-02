// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/helm-controller/api/v2beta1

package v2beta1

import (
	"github.com/fluxcd/pkg/apis/kustomize"
	apiextensionsv1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"github.com/fluxcd/pkg/apis/meta"
	"github.com/fluxcd/helm-controller/api/v2beta2"
)

#HelmReleaseKind: "HelmRelease"

#HelmReleaseFinalizer: "finalizers.fluxcd.io"

// Kustomize Helm PostRenderer specification.
#Kustomize: {
	// Strategic merge and JSON patches, defined as inline YAML objects,
	// capable of targeting objects based on kind, label and annotation selectors.
	// +optional
	patches?: [...kustomize.#Patch] @go(Patches,[]kustomize.Patch)

	// Strategic merge patches, defined as inline YAML objects.
	// +optional
	patchesStrategicMerge?: [...apiextensionsv1.#JSON] @go(PatchesStrategicMerge,[]apiextensionsv1.JSON)

	// JSON 6902 patches, defined as inline YAML objects.
	// +optional
	patchesJson6902?: [...kustomize.#JSON6902Patch] @go(PatchesJSON6902,[]kustomize.JSON6902Patch)

	// Images is a list of (image name, new name, new tag or digest)
	// for changing image names, tags or digests. This can also be achieved with a
	// patch, but this operator is simpler to specify.
	// +optional
	images?: [...kustomize.#Image] @go(Images,[]kustomize.Image)
}

// PostRenderer contains a Helm PostRenderer specification.
#PostRenderer: {
	// Kustomization to apply as PostRenderer.
	// +optional
	kustomize?: null | #Kustomize @go(Kustomize,*Kustomize)
}

// HelmReleaseSpec defines the desired state of a Helm release.
#HelmReleaseSpec: {
	// Chart defines the template of the v1beta2.HelmChart that should be created
	// for this HelmRelease.
	// +required
	chart: #HelmChartTemplate @go(Chart)

	// Interval at which to reconcile the Helm release.
	// This interval is approximate and may be subject to jitter to ensure
	// efficient use of resources.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +required
	interval: metav1.#Duration @go(Interval)

	// KubeConfig for reconciling the HelmRelease on a remote cluster.
	// When used in combination with HelmReleaseSpec.ServiceAccountName,
	// forces the controller to act on behalf of that Service Account at the
	// target cluster.
	// If the --default-service-account flag is set, its value will be used as
	// a controller level fallback for when HelmReleaseSpec.ServiceAccountName
	// is empty.
	// +optional
	kubeConfig?: null | meta.#KubeConfigReference @go(KubeConfig,*meta.KubeConfigReference)

	// Suspend tells the controller to suspend reconciliation for this HelmRelease,
	// it does not apply to already started reconciliations. Defaults to false.
	// +optional
	suspend?: bool @go(Suspend)

	// ReleaseName used for the Helm release. Defaults to a composition of
	// '[TargetNamespace-]Name'.
	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=53
	// +kubebuilder:validation:Optional
	// +optional
	releaseName?: string @go(ReleaseName)

	// TargetNamespace to target when performing operations for the HelmRelease.
	// Defaults to the namespace of the HelmRelease.
	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=63
	// +kubebuilder:validation:Optional
	// +optional
	targetNamespace?: string @go(TargetNamespace)

	// StorageNamespace used for the Helm storage.
	// Defaults to the namespace of the HelmRelease.
	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=63
	// +kubebuilder:validation:Optional
	// +optional
	storageNamespace?: string @go(StorageNamespace)

	// DependsOn may contain a meta.NamespacedObjectReference slice with
	// references to HelmRelease resources that must be ready before this HelmRelease
	// can be reconciled.
	// +optional
	dependsOn?: [...meta.#NamespacedObjectReference] @go(DependsOn,[]meta.NamespacedObjectReference)

	// Timeout is the time to wait for any individual Kubernetes operation (like Jobs
	// for hooks) during the performance of a Helm action. Defaults to '5m0s'.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +optional
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// MaxHistory is the number of revisions saved by Helm for this HelmRelease.
	// Use '0' for an unlimited number of revisions; defaults to '10'.
	// +optional
	maxHistory?: null | int @go(MaxHistory,*int)

	// The name of the Kubernetes service account to impersonate
	// when reconciling this HelmRelease.
	// +optional
	serviceAccountName?: string @go(ServiceAccountName)

	// PersistentClient tells the controller to use a persistent Kubernetes
	// client for this release. When enabled, the client will be reused for the
	// duration of the reconciliation, instead of being created and destroyed
	// for each (step of a) Helm action.
	//
	// This can improve performance, but may cause issues with some Helm charts
	// that for example do create Custom Resource Definitions during installation
	// outside Helm's CRD lifecycle hooks, which are then not observed to be
	// available by e.g. post-install hooks.
	//
	// If not set, it defaults to true.
	//
	// +optional
	persistentClient?: null | bool @go(PersistentClient,*bool)

	// DriftDetection holds the configuration for detecting and handling
	// differences between the manifest in the Helm storage and the resources
	// currently existing in the cluster.
	//
	// Note: this field is provisional to the v2beta2 API, and not actively used
	// by v2beta1 HelmReleases.
	// +optional
	driftDetection?: null | v2beta2.#DriftDetection @go(DriftDetection,*v2beta2.DriftDetection)

	// Install holds the configuration for Helm install actions for this HelmRelease.
	// +optional
	install?: null | #Install @go(Install,*Install)

	// Upgrade holds the configuration for Helm upgrade actions for this HelmRelease.
	// +optional
	upgrade?: null | #Upgrade @go(Upgrade,*Upgrade)

	// Test holds the configuration for Helm test actions for this HelmRelease.
	// +optional
	test?: null | #Test @go(Test,*Test)

	// Rollback holds the configuration for Helm rollback actions for this HelmRelease.
	// +optional
	rollback?: null | #Rollback @go(Rollback,*Rollback)

	// Uninstall holds the configuration for Helm uninstall actions for this HelmRelease.
	// +optional
	uninstall?: null | #Uninstall @go(Uninstall,*Uninstall)

	// ValuesFrom holds references to resources containing Helm values for this HelmRelease,
	// and information about how they should be merged.
	valuesFrom?: [...#ValuesReference] @go(ValuesFrom,[]ValuesReference)

	// Values holds the values for this Helm release.
	// +optional
	values?: null | apiextensionsv1.#JSON @go(Values,*apiextensionsv1.JSON)

	// PostRenderers holds an array of Helm PostRenderers, which will be applied in order
	// of their definition.
	// +optional
	postRenderers?: [...#PostRenderer] @go(PostRenderers,[]PostRenderer)
}

// HelmChartTemplate defines the template from which the controller will
// generate a v1beta2.HelmChart object in the same namespace as the referenced
// v1beta2.Source.
#HelmChartTemplate: {
	// ObjectMeta holds the template for metadata like labels and annotations.
	// +optional
	metadata?: null | #HelmChartTemplateObjectMeta @go(ObjectMeta,*HelmChartTemplateObjectMeta)

	// Spec holds the template for the v1beta2.HelmChartSpec for this HelmRelease.
	// +required
	spec: #HelmChartTemplateSpec @go(Spec)
}

// HelmChartTemplateObjectMeta defines the template for the ObjectMeta of a
// v1beta2.HelmChart.
#HelmChartTemplateObjectMeta: {
	// Map of string keys and values that can be used to organize and categorize
	// (scope and select) objects.
	// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
	// +optional
	labels?: {[string]: string} @go(Labels,map[string]string)

	// Annotations is an unstructured key value map stored with a resource that may be
	// set by external tools to store and retrieve arbitrary metadata. They are not
	// queryable and should be preserved when modifying objects.
	// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
	// +optional
	annotations?: {[string]: string} @go(Annotations,map[string]string)
}

// HelmChartTemplateSpec defines the template from which the controller will
// generate a v1beta2.HelmChartSpec object.
#HelmChartTemplateSpec: {
	// The name or path the Helm chart is available at in the SourceRef.
	// +required
	chart: string @go(Chart)

	// Version semver expression, ignored for charts from v1beta2.GitRepository and
	// v1beta2.Bucket sources. Defaults to latest when omitted.
	// +kubebuilder:default:=*
	// +optional
	version?: string @go(Version)

	// The name and namespace of the v1beta2.Source the chart is available at.
	// +required
	sourceRef: #CrossNamespaceObjectReference @go(SourceRef)

	// Interval at which to check the v1beta2.Source for updates. Defaults to
	// 'HelmReleaseSpec.Interval'.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +optional
	interval?: null | metav1.#Duration @go(Interval,*metav1.Duration)

	// Determines what enables the creation of a new artifact. Valid values are
	// ('ChartVersion', 'Revision').
	// See the documentation of the values for an explanation on their behavior.
	// Defaults to ChartVersion when omitted.
	// +kubebuilder:validation:Enum=ChartVersion;Revision
	// +kubebuilder:default:=ChartVersion
	// +optional
	reconcileStrategy?: string @go(ReconcileStrategy)

	// Alternative list of values files to use as the chart values (values.yaml
	// is not included by default), expected to be a relative path in the SourceRef.
	// Values files are merged in the order of this list with the last file overriding
	// the first. Ignored when omitted.
	// +optional
	valuesFiles?: [...string] @go(ValuesFiles,[]string)

	// Alternative values file to use as the default chart values, expected to
	// be a relative path in the SourceRef. Deprecated in favor of ValuesFiles,
	// for backwards compatibility the file defined here is merged before the
	// ValuesFiles items. Ignored when omitted.
	// +optional
	// +deprecated
	valuesFile?: string @go(ValuesFile)

	// Verify contains the secret name containing the trusted public keys
	// used to verify the signature and specifies which provider to use to check
	// whether OCI image is authentic.
	// This field is only supported for OCI sources.
	// Chart dependencies, which are not bundled in the umbrella chart artifact, are not verified.
	// +optional
	verify?: null | #HelmChartTemplateVerification @go(Verify,*HelmChartTemplateVerification)
}

// HelmChartTemplateVerification verifies the authenticity of an OCI Helm chart.
#HelmChartTemplateVerification: {
	// Provider specifies the technology used to sign the OCI Helm chart.
	// +kubebuilder:validation:Enum=cosign
	// +kubebuilder:default:=cosign
	provider: string @go(Provider)

	// SecretRef specifies the Kubernetes Secret containing the
	// trusted public keys.
	// +optional
	secretRef?: null | meta.#LocalObjectReference @go(SecretRef,*meta.LocalObjectReference)
}

// DeploymentAction defines a consistent interface for Install and Upgrade.
// +kubebuilder:object:generate=false
#DeploymentAction: _

// Remediation defines a consistent interface for InstallRemediation and
// UpgradeRemediation.
// +kubebuilder:object:generate=false
#Remediation: _

// Install holds the configuration for Helm install actions performed for this
// HelmRelease.
#Install: {
	// Timeout is the time to wait for any individual Kubernetes operation (like
	// Jobs for hooks) during the performance of a Helm install action. Defaults to
	// 'HelmReleaseSpec.Timeout'.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +optional
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// Remediation holds the remediation configuration for when the Helm install
	// action for the HelmRelease fails. The default is to not perform any action.
	// +optional
	remediation?: null | #InstallRemediation @go(Remediation,*InstallRemediation)

	// DisableWait disables the waiting for resources to be ready after a Helm
	// install has been performed.
	// +optional
	disableWait?: bool @go(DisableWait)

	// DisableWaitForJobs disables waiting for jobs to complete after a Helm
	// install has been performed.
	// +optional
	disableWaitForJobs?: bool @go(DisableWaitForJobs)

	// DisableHooks prevents hooks from running during the Helm install action.
	// +optional
	disableHooks?: bool @go(DisableHooks)

	// DisableOpenAPIValidation prevents the Helm install action from validating
	// rendered templates against the Kubernetes OpenAPI Schema.
	// +optional
	disableOpenAPIValidation?: bool @go(DisableOpenAPIValidation)

	// Replace tells the Helm install action to re-use the 'ReleaseName', but only
	// if that name is a deleted release which remains in the history.
	// +optional
	replace?: bool @go(Replace)

	// SkipCRDs tells the Helm install action to not install any CRDs. By default,
	// CRDs are installed if not already present.
	//
	// Deprecated use CRD policy (`crds`) attribute with value `Skip` instead.
	//
	// +deprecated
	// +optional
	skipCRDs?: bool @go(SkipCRDs)

	// CRDs upgrade CRDs from the Helm Chart's crds directory according
	// to the CRD upgrade policy provided here. Valid values are `Skip`,
	// `Create` or `CreateReplace`. Default is `Create` and if omitted
	// CRDs are installed but not updated.
	//
	// Skip: do neither install nor replace (update) any CRDs.
	//
	// Create: new CRDs are created, existing CRDs are neither updated nor deleted.
	//
	// CreateReplace: new CRDs are created, existing CRDs are updated (replaced)
	// but not deleted.
	//
	// By default, CRDs are applied (installed) during Helm install action.
	// With this option users can opt-in to CRD replace existing CRDs on Helm
	// install actions, which is not (yet) natively supported by Helm.
	// https://helm.sh/docs/chart_best_practices/custom_resource_definitions.
	//
	// +kubebuilder:validation:Enum=Skip;Create;CreateReplace
	// +optional
	crds?: #CRDsPolicy @go(CRDs)

	// CreateNamespace tells the Helm install action to create the
	// HelmReleaseSpec.TargetNamespace if it does not exist yet.
	// On uninstall, the namespace will not be garbage collected.
	// +optional
	createNamespace?: bool @go(CreateNamespace)
}

// InstallRemediation holds the configuration for Helm install remediation.
#InstallRemediation: {
	// Retries is the number of retries that should be attempted on failures before
	// bailing. Remediation, using an uninstall, is performed between each attempt.
	// Defaults to '0', a negative integer equals to unlimited retries.
	// +optional
	retries?: int @go(Retries)

	// IgnoreTestFailures tells the controller to skip remediation when the Helm
	// tests are run after an install action but fail. Defaults to
	// 'Test.IgnoreFailures'.
	// +optional
	ignoreTestFailures?: null | bool @go(IgnoreTestFailures,*bool)

	// RemediateLastFailure tells the controller to remediate the last failure, when
	// no retries remain. Defaults to 'false'.
	// +optional
	remediateLastFailure?: null | bool @go(RemediateLastFailure,*bool)
}

// CRDsPolicy defines the install/upgrade approach to use for CRDs when
// installing or upgrading a HelmRelease.
#CRDsPolicy: string // #enumCRDsPolicy

#enumCRDsPolicy:
	#Skip |
	#Create |
	#CreateReplace

// Skip CRDs do neither install nor replace (update) any CRDs.
#Skip: #CRDsPolicy & "Skip"

// Create CRDs which do not already exist, do not replace (update) already existing
// CRDs and keep (do not delete) CRDs which no longer exist in the current release.
#Create: #CRDsPolicy & "Create"

// Create CRDs which do not already exist, Replace (update) already existing CRDs
// and keep (do not delete) CRDs which no longer exist in the current release.
#CreateReplace: #CRDsPolicy & "CreateReplace"

// Upgrade holds the configuration for Helm upgrade actions for this
// HelmRelease.
#Upgrade: {
	// Timeout is the time to wait for any individual Kubernetes operation (like
	// Jobs for hooks) during the performance of a Helm upgrade action. Defaults to
	// 'HelmReleaseSpec.Timeout'.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +optional
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// Remediation holds the remediation configuration for when the Helm upgrade
	// action for the HelmRelease fails. The default is to not perform any action.
	// +optional
	remediation?: null | #UpgradeRemediation @go(Remediation,*UpgradeRemediation)

	// DisableWait disables the waiting for resources to be ready after a Helm
	// upgrade has been performed.
	// +optional
	disableWait?: bool @go(DisableWait)

	// DisableWaitForJobs disables waiting for jobs to complete after a Helm
	// upgrade has been performed.
	// +optional
	disableWaitForJobs?: bool @go(DisableWaitForJobs)

	// DisableHooks prevents hooks from running during the Helm upgrade action.
	// +optional
	disableHooks?: bool @go(DisableHooks)

	// DisableOpenAPIValidation prevents the Helm upgrade action from validating
	// rendered templates against the Kubernetes OpenAPI Schema.
	// +optional
	disableOpenAPIValidation?: bool @go(DisableOpenAPIValidation)

	// Force forces resource updates through a replacement strategy.
	// +optional
	force?: bool @go(Force)

	// PreserveValues will make Helm reuse the last release's values and merge in
	// overrides from 'Values'. Setting this flag makes the HelmRelease
	// non-declarative.
	// +optional
	preserveValues?: bool @go(PreserveValues)

	// CleanupOnFail allows deletion of new resources created during the Helm
	// upgrade action when it fails.
	// +optional
	cleanupOnFail?: bool @go(CleanupOnFail)

	// CRDs upgrade CRDs from the Helm Chart's crds directory according
	// to the CRD upgrade policy provided here. Valid values are `Skip`,
	// `Create` or `CreateReplace`. Default is `Skip` and if omitted
	// CRDs are neither installed nor upgraded.
	//
	// Skip: do neither install nor replace (update) any CRDs.
	//
	// Create: new CRDs are created, existing CRDs are neither updated nor deleted.
	//
	// CreateReplace: new CRDs are created, existing CRDs are updated (replaced)
	// but not deleted.
	//
	// By default, CRDs are not applied during Helm upgrade action. With this
	// option users can opt-in to CRD upgrade, which is not (yet) natively supported by Helm.
	// https://helm.sh/docs/chart_best_practices/custom_resource_definitions.
	//
	// +kubebuilder:validation:Enum=Skip;Create;CreateReplace
	// +optional
	crds?: #CRDsPolicy @go(CRDs)
}

// UpgradeRemediation holds the configuration for Helm upgrade remediation.
#UpgradeRemediation: {
	// Retries is the number of retries that should be attempted on failures before
	// bailing. Remediation, using 'Strategy', is performed between each attempt.
	// Defaults to '0', a negative integer equals to unlimited retries.
	// +optional
	retries?: int @go(Retries)

	// IgnoreTestFailures tells the controller to skip remediation when the Helm
	// tests are run after an upgrade action but fail.
	// Defaults to 'Test.IgnoreFailures'.
	// +optional
	ignoreTestFailures?: null | bool @go(IgnoreTestFailures,*bool)

	// RemediateLastFailure tells the controller to remediate the last failure, when
	// no retries remain. Defaults to 'false' unless 'Retries' is greater than 0.
	// +optional
	remediateLastFailure?: null | bool @go(RemediateLastFailure,*bool)

	// Strategy to use for failure remediation. Defaults to 'rollback'.
	// +kubebuilder:validation:Enum=rollback;uninstall
	// +optional
	strategy?: null | #RemediationStrategy @go(Strategy,*RemediationStrategy)
}

// RemediationStrategy returns the strategy to use to remediate a failed install
// or upgrade.
#RemediationStrategy: string // #enumRemediationStrategy

#enumRemediationStrategy:
	#RollbackRemediationStrategy |
	#UninstallRemediationStrategy

// RollbackRemediationStrategy represents a Helm remediation strategy of Helm
// rollback.
#RollbackRemediationStrategy: #RemediationStrategy & "rollback"

// UninstallRemediationStrategy represents a Helm remediation strategy of Helm
// uninstall.
#UninstallRemediationStrategy: #RemediationStrategy & "uninstall"

// Test holds the configuration for Helm test actions for this HelmRelease.
#Test: {
	// Enable enables Helm test actions for this HelmRelease after an Helm install
	// or upgrade action has been performed.
	// +optional
	enable?: bool @go(Enable)

	// Timeout is the time to wait for any individual Kubernetes operation during
	// the performance of a Helm test action. Defaults to 'HelmReleaseSpec.Timeout'.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +optional
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// IgnoreFailures tells the controller to skip remediation when the Helm tests
	// are run but fail. Can be overwritten for tests run after install or upgrade
	// actions in 'Install.IgnoreTestFailures' and 'Upgrade.IgnoreTestFailures'.
	// +optional
	ignoreFailures?: bool @go(IgnoreFailures)
}

// Rollback holds the configuration for Helm rollback actions for this
// HelmRelease.
#Rollback: {
	// Timeout is the time to wait for any individual Kubernetes operation (like
	// Jobs for hooks) during the performance of a Helm rollback action. Defaults to
	// 'HelmReleaseSpec.Timeout'.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +optional
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// DisableWait disables the waiting for resources to be ready after a Helm
	// rollback has been performed.
	// +optional
	disableWait?: bool @go(DisableWait)

	// DisableWaitForJobs disables waiting for jobs to complete after a Helm
	// rollback has been performed.
	// +optional
	disableWaitForJobs?: bool @go(DisableWaitForJobs)

	// DisableHooks prevents hooks from running during the Helm rollback action.
	// +optional
	disableHooks?: bool @go(DisableHooks)

	// Recreate performs pod restarts for the resource if applicable.
	// +optional
	recreate?: bool @go(Recreate)

	// Force forces resource updates through a replacement strategy.
	// +optional
	force?: bool @go(Force)

	// CleanupOnFail allows deletion of new resources created during the Helm
	// rollback action when it fails.
	// +optional
	cleanupOnFail?: bool @go(CleanupOnFail)
}

// Uninstall holds the configuration for Helm uninstall actions for this
// HelmRelease.
#Uninstall: {
	// Timeout is the time to wait for any individual Kubernetes operation (like
	// Jobs for hooks) during the performance of a Helm uninstall action. Defaults
	// to 'HelmReleaseSpec.Timeout'.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +optional
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// DisableHooks prevents hooks from running during the Helm rollback action.
	// +optional
	disableHooks?: bool @go(DisableHooks)

	// KeepHistory tells Helm to remove all associated resources and mark the
	// release as deleted, but retain the release history.
	// +optional
	keepHistory?: bool @go(KeepHistory)

	// DisableWait disables waiting for all the resources to be deleted after
	// a Helm uninstall is performed.
	// +optional
	disableWait?: bool @go(DisableWait)

	// DeletionPropagation specifies the deletion propagation policy when
	// a Helm uninstall is performed.
	// +kubebuilder:default=background
	// +kubebuilder:validation:Enum=background;foreground;orphan
	// +optional
	deletionPropagation?: null | string @go(DeletionPropagation,*string)
}

// HelmReleaseStatus defines the observed state of a HelmRelease.
#HelmReleaseStatus: {
	// ObservedGeneration is the last observed generation.
	// +optional
	observedGeneration?: int64 @go(ObservedGeneration)

	meta.#ReconcileRequestStatus

	// Conditions holds the conditions for the HelmRelease.
	// +optional
	conditions?: [...metav1.#Condition] @go(Conditions,[]metav1.Condition)

	// LastAppliedRevision is the revision of the last successfully applied source.
	// +optional
	lastAppliedRevision?: string @go(LastAppliedRevision)

	// LastAttemptedRevision is the revision of the last reconciliation attempt.
	// +optional
	lastAttemptedRevision?: string @go(LastAttemptedRevision)

	// LastAttemptedValuesChecksum is the SHA1 checksum of the values of the last
	// reconciliation attempt.
	// +optional
	lastAttemptedValuesChecksum?: string @go(LastAttemptedValuesChecksum)

	// LastReleaseRevision is the revision of the last successful Helm release.
	// +optional
	lastReleaseRevision?: int @go(LastReleaseRevision)

	// HelmChart is the namespaced name of the HelmChart resource created by
	// the controller for the HelmRelease.
	// +optional
	helmChart?: string @go(HelmChart)

	// Failures is the reconciliation failure count against the latest desired
	// state. It is reset after a successful reconciliation.
	// +optional
	failures?: int64 @go(Failures)

	// InstallFailures is the install failure count against the latest desired
	// state. It is reset after a successful reconciliation.
	// +optional
	installFailures?: int64 @go(InstallFailures)

	// UpgradeFailures is the upgrade failure count against the latest desired
	// state. It is reset after a successful reconciliation.
	// +optional
	upgradeFailures?: int64 @go(UpgradeFailures)

	// StorageNamespace is the namespace of the Helm release storage for the
	// current release.
	//
	// Note: this field is provisional to the v2beta2 API, and not actively used
	// by v2beta1 HelmReleases.
	// +optional
	storageNamespace?: string @go(StorageNamespace)

	// History holds the history of Helm releases performed for this HelmRelease
	// up to the last successfully completed release.
	//
	// Note: this field is provisional to the v2beta2 API, and not actively used
	// by v2beta1 HelmReleases.
	// +optional
	history?: v2beta2.#Snapshots @go(History)

	// LastAttemptedGeneration is the last generation the controller attempted
	// to reconcile.
	//
	// Note: this field is provisional to the v2beta2 API, and not actively used
	// by v2beta1 HelmReleases.
	// +optional
	lastAttemptedGeneration?: int64 @go(LastAttemptedGeneration)

	// LastAttemptedConfigDigest is the digest for the config (better known as
	// "values") of the last reconciliation attempt.
	//
	// Note: this field is provisional to the v2beta2 API, and not actively used
	// by v2beta1 HelmReleases.
	// +optional
	lastAttemptedConfigDigest?: string @go(LastAttemptedConfigDigest)

	// LastAttemptedReleaseAction is the last release action performed for this
	// HelmRelease. It is used to determine the active remediation strategy.
	//
	// Note: this field is provisional to the v2beta2 API, and not actively used
	// by v2beta1 HelmReleases.
	// +optional
	lastAttemptedReleaseAction?: string @go(LastAttemptedReleaseAction)

	// LastHandledForceAt holds the value of the most recent force request
	// value, so a change of the annotation value can be detected.
	//
	// Note: this field is provisional to the v2beta2 API, and not actively used
	// by v2beta1 HelmReleases.
	// +optional
	lastHandledForceAt?: string @go(LastHandledForceAt)

	// LastHandledResetAt holds the value of the most recent reset request
	// value, so a change of the annotation value can be detected.
	//
	// Note: this field is provisional to the v2beta2 API, and not actively used
	// by v2beta1 HelmReleases.
	// +optional
	lastHandledResetAt?: string @go(LastHandledResetAt)
}

// SourceIndexKey is the key used for indexing HelmReleases based on
// their sources.
#SourceIndexKey: ".metadata.source"

// HelmRelease is the Schema for the helmreleases API
#HelmRelease: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec?:     #HelmReleaseSpec   @go(Spec)

	// +kubebuilder:default:={"observedGeneration":-1}
	status?: #HelmReleaseStatus @go(Status)
}

// HelmReleaseList contains a list of HelmRelease objects.
#HelmReleaseList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#HelmRelease] @go(Items,[]HelmRelease)
}
