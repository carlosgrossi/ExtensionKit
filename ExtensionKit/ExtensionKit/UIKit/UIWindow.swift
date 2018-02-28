//
//  UIWindow.swift
//  ExtensionKit
//
//  Created by Carlos Grossi on 24/06/17.
//  Copyright © 2017 Carlos Grossi. All rights reserved.
//

import Foundation

extension UIWindow {
	
    public var statusBarBackgroundColor: UIColor? {
        set {
            self.subviews.first(where: { $0.tag == 99 })?.removeFromSuperview()
            
            guard newValue != nil else { return }
            let statusBarBackgroundView = UIView()
            statusBarBackgroundView.backgroundColor = newValue
            statusBarBackgroundView.tag = 99
            self.addSubview(statusBarBackgroundView)
            _ = self.applyStandardConstraints(onSubview: statusBarBackgroundView, attributes: [.leading, .top, .trailing])
            _ = statusBarBackgroundView.applyHeightConstraint(height: UIApplication.shared.statusBarFrame.height)
        }
        get {
            return self.subviews.first(where: { $0.tag == 99 })?.backgroundColor
        }
    }
    
}
