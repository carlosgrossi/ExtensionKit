//
//  UIView.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

public extension UIView {
	
    // swiftlint:disable identifier_name
	var x: CGFloat {
        return frame.origin.x
	}
	
	var y: CGFloat {
		return frame.origin.y
	}
    // swiftlint:enable identifier_name
	
	var width: CGFloat {
		return frame.width
	}
	
	var height: CGFloat {
		return frame.height
	}
	
	@IBInspectable var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}
	
	@IBInspectable var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}
	
	@IBInspectable var borderColor: UIColor? {
		get {
			return UIColor(cgColor: (layer.borderColor ?? UIColor.clear.cgColor))
		}
		set {
			layer.borderColor = newValue?.cgColor
		}
	}
	
	func addSubview(view: UIView?) {
		guard let view = view else { return }
		self.addSubview(view)
	}
	
	/// Apply a standard constraint where the attributes, constants, multipliers and priorities are equal to the receiving item. 
	/// Useful to apply constraints where leading, trailing, top and bottom matches.
	///
	/// - Parameters:
	///   - subview: The item receiving the constraint
	///   - attributes: attributes that the constraints should be applied at.
	/// - Returns: An array with all constraints created
    @discardableResult
	func applyStandardConstraints(onSubview subview: UIView?, attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .left, .right], constants: [CGFloat] = []) -> [NSLayoutConstraint?] {
		var constraints: [NSLayoutConstraint?] = []
		for (index, attribute) in attributes.enumerated() {
			let constant = index < constants.count ? constants[index] : 0
			constraints.append(applyContraint(onView: subview, attribute: attribute, relatetBy: .equal, toItem: self, constant: constant))
		}
		return constraints
	}
	
    @discardableResult
	func applySizeConstraint(size: CGSize, multiplier: CGFloat = 1, priority: Float = 1000) -> [NSLayoutConstraint?] {
		var constraints: [NSLayoutConstraint?] = []
		constraints.append(applyHeightConstraint(height: size.height))
		constraints.append(applyWidthConstraint(width: size.width))
		return constraints
	}
	
    @discardableResult
	func applyHeightConstraint(height: CGFloat, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint? {
		return self.applyContraint(onView: self, attribute: .height, multiplier: multiplier, constant: height, priority: priority)
	}
	
    @discardableResult
	func applyWidthConstraint(width: CGFloat, multiplier: CGFloat = 1, priority: Float = 1000) -> NSLayoutConstraint? {
		return self.applyContraint(onView: self, attribute: .width, multiplier: multiplier, constant: width, priority: priority)
	}
	
    //swiftlint:disable identifier_name
    @discardableResult
	func applyCentralizeConstraint(onView subview: UIView?, axis: [NSLayoutConstraint.Attribute] = [.centerX, .centerY]) -> [NSLayoutConstraint] {
		var constraints: [NSLayoutConstraint] = []
		for ax in axis {
			if let constraint = applyContraint(onView: subview, attribute: ax, relatetBy: .equal, toItem: self) {
				constraints.append(constraint)
			}
		}
		return constraints
	}
    //swiftlint:enable identifier_name
	
    @discardableResult
	func applyContraint(
        onView subview: UIView?,
        attribute: NSLayoutConstraint.Attribute,
        relatetBy: NSLayoutConstraint.Relation = .equal,
        toItem: Any? = nil,
        toAttribute: NSLayoutConstraint.Attribute? = nil,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0,
        priority: Float = 1000.0) -> NSLayoutConstraint? {
		
		guard let subview = subview else { return nil }
		subview.translatesAutoresizingMaskIntoConstraints = false
		
		let selfAttribute = toAttribute ?? attribute
		let constraint = NSLayoutConstraint(item: subview, attribute: attribute, relatedBy: relatetBy, toItem: toItem, attribute: selfAttribute, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(rawValue: priority)
		constraint.isActive = true
		self.addConstraint(constraint)
		
		return constraint
	}
	
	func roundCorners(_ roundedCorners: UIRectCorner, offset: CGRect, cornerRadius: Int) {
		var frame = self.frame
		frame.origin.x += offset.origin.x
		frame.origin.y += offset.origin.y
		frame.size.width += offset.size.width
		frame.size.height += offset.size.height
		
		let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
		let maskLayer = CAShapeLayer()
		
		maskLayer.backgroundColor = UIColor.black.cgColor
		maskLayer.path = UIBezierPath(roundedRect: frame, byRoundingCorners: roundedCorners, cornerRadii: cornerRadii).cgPath
		layer.mask = maskLayer
	}
	
	func shake(duration: CFTimeInterval, repeatCount: Float, autoreverses: Bool, xOffset: CGFloat, yOffset: CGFloat, completion:(() -> Void)? = nil) {
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		
		let animation = CABasicAnimation(keyPath: "position")
		animation.duration = duration
		animation.repeatCount = repeatCount
		animation.autoreverses = autoreverses
		animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - xOffset, y: self.center.y - yOffset))
		animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + xOffset, y: self.center.y + yOffset))
		
		self.layer.add(animation, forKey: "position")
		CATransaction.commit()
	}
	
	func fade(to alpha: CGFloat, duration: TimeInterval = 0.5, removingFromSuperview: Bool = false, completion: ((Bool) -> Void)? = nil) {
        // swiftlint:disable multiple_closures_with_trailing_closure
		UIView.animate(withDuration: duration, animations: {
			self.alpha = alpha
		}) { (complete) in
			self.alpha = alpha
			if removingFromSuperview { self.removeFromSuperview() }
			completion?(complete)
		}
        // swiftlint:enable multiple_closures_with_trailing_closure
	}
	
	func roundedCorners(cornerRadius: CGFloat, borderWidth: CGFloat = 0.0, borderColor: UIColor = .black) {
		self.cornerRadius = cornerRadius
		self.borderWidth = borderWidth
		self.borderColor = borderColor
	}
	
	func addTapToKeyboadDismiss() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tapGestureRecognizer.cancelsTouchesInView = false
		self.addGestureRecognizer(tapGestureRecognizer)
	}
	
	@objc fileprivate func dismissKeyboard() {
		self.endEditing(true)
	}
	
    func taggedSubviews() -> Dictionary<Int, UIView> {
        var taggedSubviews: Dictionary<Int, UIView> = Dictionary()
        for subview in self.subviews.filter({ $0.tag != 0 }) {
            taggedSubviews.updateValue(subview, forKey: subview.tag)
        }
        return taggedSubviews
    }
    
    func firstAvailableTag() -> Int {
        var availableTag = Int.max
        let taggedSubviews = self.taggedSubviews()
        while taggedSubviews[availableTag] != nil {
            availableTag -= 1
        }
        return availableTag
    }
    
}
