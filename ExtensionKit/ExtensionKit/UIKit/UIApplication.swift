//
//  UIApplication.swift
//  ExtensionKit
//
//  Created by Carlos Grossi on 20/08/17.
//  Copyright © 2017 Carlos Grossi. All rights reserved.
//

import UIKit

public extension UIApplication {
	
	@available(iOS 9.0, *)
	func appendShortcutItem(_ item: UIApplicationShortcutItem) {
		removeShortcutItem(item)
		shortcutItems?.append(item)
	}
	
	@available(iOS 9.0, *)
	func appendShortcutItem(ofType type: String, localizedTitle: String, localizedSubtitle: String, icon: UIApplicationShortcutIcon? = nil, userInfo: [AnyHashable: Any]? = nil) {
		appendShortcutItem(UIMutableApplicationShortcutItem(type: type, localizedTitle: localizedTitle, localizedSubtitle: localizedSubtitle, icon: icon, userInfo: userInfo as? [String: NSSecureCoding]))
	}
	
	@available(iOS 9.0, *)
	func appendShortcutItem(ofType type: String, localizedTitle: String, localizedSubtitle: String, iconNamed templateImageName: String? = nil, userInfo: [AnyHashable: Any]? = nil) {
		let icon = UIApplicationShortcutIcon(templateImageName: templateImageName ?? "")
		appendShortcutItem(UIMutableApplicationShortcutItem(type: type, localizedTitle: localizedTitle, localizedSubtitle: localizedSubtitle, icon: icon, userInfo: userInfo as? [String: NSSecureCoding]))
	}
	
	@available(iOS 9.0, *)
	func removeShortcutItem(_ item: UIApplicationShortcutItem) {
		if let installedItems = shortcutItems?.filter({ $0.type == item.type }) {
			for installedItem in installedItems.enumerated() {
				if let installedItemIndex = shortcutItems?.firstIndex(of: installedItem.element) {
					shortcutItems?.remove(at: installedItemIndex)
				}
			}
		}
	}
	
}
