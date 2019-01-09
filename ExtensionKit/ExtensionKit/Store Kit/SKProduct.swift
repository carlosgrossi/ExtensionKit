//
//  SKProduct.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import StoreKit

public extension SKProduct {
	
	public var localizedPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
	}
	
}
