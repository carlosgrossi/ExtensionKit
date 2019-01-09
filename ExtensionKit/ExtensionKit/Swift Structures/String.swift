//
//  String.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import UIKit

public extension String {
	
	public func rangesOf(substring: String) -> [NSRange] {
		let inputLength = self.count
		
		var rangesFound: [NSRange] = []
		var range = NSRange(location: 0, length: inputLength)
		
		while range.location != NSNotFound {
			range = (self as NSString).range(of: substring, options: [], range: range)
			if range.location != NSNotFound {
				rangesFound.append(range)
				range = NSRange(location: range.location + 1, length: inputLength - range.location - 1)
			} else {
				return rangesFound
			}
		}
		
		return []
	}
	
	public func boundingRect(forFont font: UIFont, inView view: UIView) -> CGRect {
		let baseRect = CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        return self.boundingRect(with: baseRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
	}
	
}
