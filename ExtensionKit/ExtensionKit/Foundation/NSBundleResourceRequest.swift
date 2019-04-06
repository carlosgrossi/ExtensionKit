//
//  NSBundleResourceRequest.swift
//  ExtensionKit
//
//  Created by Carlos Grossi on 23/06/17.
//  Copyright © 2017 Carlos Grossi. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
public extension NSBundleResourceRequest {
	
	static func beginAccessingResources(with tags: Set<String>, progressObserver: NSObject? = nil, completion: (() -> Void)? = nil) -> NSBundleResourceRequest {
		let resourceRequest = NSBundleResourceRequest(tags: tags)
		resourceRequest.conditionallyBeginAccessingResources { (resourcesAvailable) in
			if !resourcesAvailable {
				resourceRequest.loadingPriority = NSBundleResourceRequestLoadingPriorityUrgent
				resourceRequest.beginAccessingResources(completionHandler: { (_) in
					if let progressObserver = progressObserver {
						resourceRequest.progress.removeObserver(progressObserver, forKeyPath: "fractionCompleted")
					}
					completion?()
				})
			} else {
				if let progressObserver = progressObserver {
					resourceRequest.progress.removeObserver(progressObserver, forKeyPath: "fractionCompleted")
				}
				completion?()
			}
		}
		
		if let progressObserver = progressObserver {
			resourceRequest.progress.addObserver(progressObserver, forKeyPath: "fractionCompleted", options: NSKeyValueObservingOptions.new, context: nil)
		}
		
		return resourceRequest
	}
	
}
