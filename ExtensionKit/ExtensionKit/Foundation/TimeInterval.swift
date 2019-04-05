//
//  TimeInterval.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

public extension TimeInterval {
	
	/// Time interval duration in hours, minutes, seconds format
	var duration: String {
        let seconds = Int(self) % 60
        let minutes = (Int(self) / 60) % 60
        let hours = (Int(self) / 3600)
        return String(format: "%02d%@ %02d%@ %02d%@", hours, "h", minutes, "m", seconds, "s")
	}
	
}
