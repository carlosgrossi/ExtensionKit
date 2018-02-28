//
//  UITextView.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

public extension UITextView {
	
	override open var contentSize: CGSize {
		didSet {
			var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
			topCorrection = max(0, topCorrection)
			contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
		}
	}
	
}
