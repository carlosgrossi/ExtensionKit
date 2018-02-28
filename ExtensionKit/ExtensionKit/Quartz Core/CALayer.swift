//
//  CALayer.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

extension CALayer {
	
	public func addFadeAnimation(timingFunction: String = kCAMediaTimingFunctionEaseInEaseOut,
	                             type: String = kCATransitionFade,
	                             duration: CFTimeInterval = 0.5) {
		let animation = CATransition()
		animation.timingFunction = CAMediaTimingFunction(name: timingFunction)
		animation.type = type
		animation.duration = duration
		self.add(animation, forKey: type)
	}
	
}
