//
//  Date.swift
//  ExtensionKit
//
//  Created by Carlos Grossi on 17/02/18.
//  Copyright © 2018 Carlos Grossi. All rights reserved.
//

import Foundation

public extension Date {
    
    public static func timeInterval(_ doubleValue: Double) -> TimeInterval {
        return doubleValue
    }
    
    // swiftlint:disable function_body_length
    // swiftlint:disable cyclomatic_complexity
    public func timeAgo(usingNumericDates: Bool) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self)
        let latest = (earliest == now) ? self : now
        let components: DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute,
                                                                              NSCalendar.Unit.hour,
                                                                              NSCalendar.Unit.day,
                                                                              NSCalendar.Unit.weekOfYear,
                                                                              NSCalendar.Unit.month,
                                                                              NSCalendar.Unit.year,
                                                                              NSCalendar.Unit.second],
                                                                             from: earliest,
                                                                             to: latest,
                                                                             options: NSCalendar.Options())
        
        // swiftlint:disable force_unwrapping
        let year = (components.year != nil) ? components.year! : 0
        let month = (components.month != nil) ? components.month! : 0
        let weekOfYear = (components.weekOfYear != nil) ? components.weekOfYear! : 0
        let day = (components.day != nil) ? components.day! : 0
        let hour = (components.hour != nil) ? components.hour! : 0
        let minute = (components.minute != nil) ? components.minute! : 0
        let second = (components.second != nil) ? components.second! : 0
        // swiftlint:enable force_unwrapping
        
        if year >= 2 {
            return "\(year) years ago"
        } else if year >= 1 {
            if usingNumericDates {
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if month >= 2 {
            return "\(month) months ago"
        } else if month >= 1 {
            if usingNumericDates {
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if weekOfYear >= 2 {
            return "\(weekOfYear) weeks ago"
        } else if weekOfYear >= 1 {
            if usingNumericDates {
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if day >= 2 {
            return "\(day) days ago"
        } else if day >= 1 {
            if usingNumericDates {
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if hour >= 2 {
            return "\(hour) hours ago"
        } else if hour >= 1 {
            if usingNumericDates {
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if minute >= 2 {
            return "\(minute) minutes ago"
        } else if minute >= 1 {
            if usingNumericDates {
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if second >= 3 {
            return "\(second) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    // swiftlint:enable function_body_length
    // swiftlint:enable cyclomatic_complexity
    
}
