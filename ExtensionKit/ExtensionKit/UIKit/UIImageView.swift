//
//  UIImageView.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

let imageCache = NSCache<AnyObject, AnyObject>()

public extension UIImageView {
	
	var asyncImage: UIImage? {
		get { return self.image }
		set {
			layer.contents = nil
			DispatchQueue.global(qos: .userInitiated).async {
				let decodedImage = self.decodeImage(newValue)
				DispatchQueue.main.async {
					self.layer.contents = decodedImage?.cgImage
				}
			}
		}
	}
	
	private func decodeImage(_ image: UIImage?) -> UIImage? {
		guard let newImage = image?.cgImage else { return nil }
		let colorspace = CGColorSpaceCreateDeviceRGB()
		let context = CGContext(data: nil,
                                width: newImage.width,
                                height: newImage.height,
                                bitsPerComponent: 8,
                                bytesPerRow: newImage.width * 4,
                                space: colorspace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
		context?.draw(newImage, in: CGRect(x: 0, y: 0, width: newImage.width, height: newImage.height))
		let decodedImage = context?.makeImage()
		
		if let decodedImage = decodedImage {
			return UIImage(cgImage: decodedImage)
		}
		
		return nil
	}
	
	convenience init(asyncImage: UIImage?) {
		self.init()
		self.asyncImage = asyncImage
	}
	
}

public extension UIImageView {
	
	/**
	Change the image from a UIImageView with a Cross Fade effect
	
	- Parameter toImage: The final image on the cross fade animation
	- Parameter duration: The duration in seconds of the animation
	*/
	func crossFade(_ toImage: UIImage?, duration: CFTimeInterval) {
		let crossFade = CABasicAnimation(keyPath: "contents")
		crossFade.duration = duration
		crossFade.fromValue = self.image?.cgImage
		crossFade.toValue = toImage?.cgImage
		self.layer.add(crossFade, forKey: "animateContents")
		self.image = toImage
	}
	
	/**
	Mask the current image from a UIImageView with a mask image
	
	- Parameter maskImage: Image that will be used as a mask
	*/
	func maskImage(_ maskImage: UIImage) {
		guard let image = self.image else { return }
		guard let maskRef = maskImage.cgImage else { return }
		guard let dataProvider = maskRef.dataProvider else { return }
		guard let mask = CGImage(maskWidth: maskRef.width,
		                         height: maskRef.height,
		                         bitsPerComponent: maskRef.bitsPerComponent,
		                         bitsPerPixel: maskRef.bitsPerPixel,
		                         bytesPerRow: maskRef.bytesPerRow,
		                         provider: dataProvider,
		                         decode: nil,
		                         shouldInterpolate: false)
			else { return }
		
		guard let maskedImageRef = image.cgImage?.masking(mask) else { return }
		let maskedImage = UIImage(cgImage: maskedImageRef)
		self.image = maskedImage
	}
	
	/**
	Load image from a remote server and sets it as UIImageView image
	
	- Parameter imageURL: URL for an image on a remote server
	- Parameter crossfadin: Set image with crossfade animation
	*/
	func setImage(from imageURL: URL?, crossfading: Bool = true, duration: TimeInterval = 1, completitionHandler:(() -> Void)? = nil) {
		guard let imageURL = imageURL else { completitionHandler?(); return }
		if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as AnyObject) as? UIImage {
			if crossfading {
				self.crossFade(cachedImage, duration: duration)
				completitionHandler?()
			} else {
				self.image = cachedImage
				completitionHandler?()
			}
			return
		}
		
		URLSession.dataTask(with: imageURL) { (data, _, error) in
			guard error == nil else { completitionHandler?(); return }
			guard let imageData = data else { completitionHandler?(); return }
			
			let image = UIImage(data: imageData)
			DispatchQueue.main.async(execute: {
				
				if crossfading {
					self.crossFade(image, duration: duration)
					completitionHandler?()
				} else {
					self.image = image
					completitionHandler?()
				}
				
			})
			
			if let unwrappedImage = image {
				imageCache.setObject(unwrappedImage, forKey: imageURL.absoluteString as AnyObject)
			}
		}
	}
	
	func setImage(from imageData: Data?, imageCacheKey: String, crossfading: Bool = true, duration: TimeInterval = 1, completitionHandler:(() -> Void)? = nil) {
		guard let imageData = imageData else { completitionHandler?(); return }
		
		if let cachedImage = imageCache.object(forKey: imageCacheKey as AnyObject) as? UIImage {
			if crossfading {
				self.crossFade(cachedImage, duration: duration)
				completitionHandler?()
			} else {
				self.image = cachedImage
				completitionHandler?()
			}
			return
		}
		
		let image = UIImage(data: imageData)
		DispatchQueue.main.async(execute: {
			
			if crossfading {
				self.crossFade(image, duration: duration)
				completitionHandler?()
			} else {
				self.image = image
				completitionHandler?()
			}
			
		})
		
		if let unwrappedImage = image {
			imageCache.setObject(unwrappedImage, forKey: imageCacheKey as AnyObject)
		}
		
	}
	
}
