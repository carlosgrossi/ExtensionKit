//
//  UIImage.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import AVFoundation

public extension UIImage {
	
	public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
		let rect = CGRect(origin: .zero, size: size)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
		color.setFill()
		UIRectFill(rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		guard let cgImage = image?.cgImage else { return nil }
		self.init(cgImage: cgImage)
	}
	
	public static func maskedImage(_ image: UIImage, withMask maskImage: UIImage) -> UIImage? {
		guard let maskRef = maskImage.cgImage else { return nil }
		guard let dataProvider = maskRef.dataProvider else { return nil }
		guard let mask = CGImage(maskWidth: maskRef.width,
		                         height: maskRef.height,
		                         bitsPerComponent: maskRef.bitsPerComponent,
		                         bitsPerPixel: maskRef.bitsPerPixel,
		                         bytesPerRow: maskRef.bytesPerRow,
		                         provider: dataProvider,
		                         decode: nil,
		                         shouldInterpolate: false)
			else { return nil }
		guard let maskedImageRef = image.cgImage?.masking(mask) else { return nil }
		return UIImage(cgImage: maskedImageRef)
	}
	
	public func scaledImage(byFactor factor: Int) -> UIImage? {
		guard let cgImage = self.cgImage else { return nil }
		guard factor > 0 else { return nil }
		
		let context = CGContext.context(with: cgImage, size: CGSize(width: cgImage.width / factor, height: cgImage.height / factor))
		return context?.makeImage().flatMap { UIImage(cgImage: $0) }
	}
	
	public func scaledImage(byFixedWidth width: Int) -> UIImage? {
		guard let cgImage = self.cgImage else { return nil }
		let context = CGContext.context(with: cgImage, size: CGSize(width: width, height: ( cgImage.height * width ) / cgImage.width ))
		return context?.makeImage().flatMap { UIImage(cgImage: $0) }
	}
	
	public func scaledImage(byFixedHeight height: Int) -> UIImage? {
		guard let cgImage = self.cgImage else { return nil }
		let context = CGContext.context(with: cgImage, size: CGSize(width: ( cgImage.width * height ) / cgImage.height, height: height))
		return context?.makeImage().flatMap { UIImage(cgImage: $0) }
	}
	
	public func scaledImage(inRect rect: CGRect) -> UIImage? {
		guard let cgImage = self.cgImage else { return nil }
		let scaleRect = AVMakeRect(aspectRatio: self.size, insideRect: rect)
		let context = CGContext.context(with: cgImage, size: scaleRect.size)
		return context?.makeImage().flatMap { UIImage(cgImage: $0) }
	}
	
}
