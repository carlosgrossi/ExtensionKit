//
//  UINavigationController.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

extension UINavigationController {
	
	public var navigationBarSize: CGSize {
		return navigationBar.frame.size
	}
	
    override open var shouldAutorotate: Bool {
		return visibleViewController?.shouldAutorotate ?? true
	}
	
	override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return visibleViewController?.supportedInterfaceOrientations ?? .all
	}
	
	public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		pushViewController(viewController, animated: animated)
		CATransaction.commit()
	}
	
	public var tabBarHeight: CGFloat? {
        return tabBarController?.tabBar.bounds.height
	}
	
	public func fadeTitle(to title: String, withDuration: TimeInterval = 0.1) {
		let fadeTransition = CATransition()
		fadeTransition.type = CATransitionType.fade
		fadeTransition.duration = withDuration
		self.navigationBar.layer.add(fadeTransition, forKey: "fadeText")
		self.viewControllers.first?.navigationItem.title = title
	}
	
}
