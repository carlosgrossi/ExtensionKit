//
//  NotificationCenter.swift
//  ExtensionKit
//
//  Created by Carlos Grossi on 20/08/17.
//  Copyright © 2017 Carlos Grossi. All rights reserved.
//

import Foundation

public extension NotificationCenter {
	
	func post(name: NSNotification.Name?, object: Any?, userInfo: [AnyHashable: Any]?) {
		guard let name = name else { return }
		post(name: name, object: object, userInfo: userInfo)
	}
	
}
