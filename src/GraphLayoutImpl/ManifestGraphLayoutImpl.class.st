"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGraphLayoutImpl,
	#superclass : #PackageManifest,
	#category : #'GraphLayoutImpl-Manifest'
}

{ #category : #'code-critics' }
ManifestGraphLayoutImpl class >> ruleUnoptimizedAndOrRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#GraphLayout #rearrangeNodes #false)) #'2021-05-19T22:40:22.765878+02:00') )
]
