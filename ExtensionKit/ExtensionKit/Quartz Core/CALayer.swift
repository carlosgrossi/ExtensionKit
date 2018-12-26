//
//  CALayer.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

extension CALayer {
	
	public func addFadeAnimation(timingFunction: String = convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeInEaseOut),
	                             type: String = convertFromCATransitionType(CATransitionType.fade),
	                             duration: CFTimeInterval = 0.5) {
		let animation = CATransition()
		animation.timingFunction = CAMediaTimingFunction(name: convertToCAMediaTimingFunctionName(timingFunction))
		animation.type = convertToCATransitionType(type)
		animation.duration = duration
		self.add(animation, forKey: type)
	}
	
}

public func convertFromCAMediaTimingFunctionName(_ input: CAMediaTimingFunctionName) -> String {
	return input.rawValue
}

public func convertFromCATransitionType(_ input: CATransitionType) -> String {
	return input.rawValue
}

public func convertToCAMediaTimingFunctionName(_ input: String) -> CAMediaTimingFunctionName {
	return CAMediaTimingFunctionName(rawValue: input)
}

public func convertToCATransitionType(_ input: String) -> CATransitionType {
	return CATransitionType(rawValue: input)
}
