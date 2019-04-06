//
//  NSMutableString.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

public extension NSMutableAttributedString {
	
	enum AtributeSearchType {
		case first, all, last
	}
	
	func attributeRangeFor(_ searchString: String, attributeValue: AnyObject, atributeSearchType: AtributeSearchType) {
		let inputLength = self.string.count
		let searchLength = searchString.count
		var range = NSRange(location: 0, length: self.length)
		var rangeCollection = [NSRange]()
		
		while range.location != NSNotFound {
			range = (self.string as NSString).range(of: searchString, options: [], range: range)
			if range.location != NSNotFound {
				switch atributeSearchType {
				case .first:
                    self.addAttribute(NSAttributedString.Key.foregroundColor, value: attributeValue, range: NSRange(location: range.location, length: searchLength))
					return
				case .all:
                    self.addAttribute(NSAttributedString.Key.foregroundColor, value: attributeValue, range: NSRange(location: range.location, length: searchLength))
				case .last:
					rangeCollection.append(range)
				}
				
				range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
			}
		}
		
		switch atributeSearchType {
		case .last:
			let indexOfLast = rangeCollection.count - 1
            self.addAttribute(NSAttributedString.Key.foregroundColor, value: attributeValue, range: rangeCollection[indexOfLast])
		default:
			break
		}
	}
	
}
