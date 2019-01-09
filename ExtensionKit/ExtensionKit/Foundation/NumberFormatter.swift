//
//  NumberFormatter.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

public extension NumberFormatter {
	
	/// Convenience Initializer that sets number style, minimum and maximum fraction digits and locale
	///
	/// - Parameters:
	///   - numberStyle: The number style used by the receiver.
	///   - maximumFractionDigits: The maximum number of digits after the decimal separator allowed as input and output by the receiver.
	///   - minimumFractionDigits: The minimum number of digits after the decimal separator allowed as input and output by the receiver.
	///   - locale: The locale of the receiver.
	public convenience init(numberStyle: NumberFormatter.Style, maximumFractionDigits: Int = 0, minimumFractionDigits: Int = 0, locale: Locale = Locale.current) {
		self.init()
		self.numberStyle = numberStyle
		self.maximumFractionDigits = maximumFractionDigits
		self.minimumFractionDigits = minimumFractionDigits
		self.locale = Locale.current
	}
	
}
