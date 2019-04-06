//
//  UICollectionView.swift
//  Pods
//
//  Created by Carlos Grossi on 19/06/17.
//
//

import Foundation

public extension UICollectionView {
	
	func adjustLayoutToCenter(usefulArea: CGFloat, itemWidth: CGFloat) {
		let numberOfItems = self.numberOfItems(inSection: 0)
		let frameWidth = frame.width
		let margin: CGFloat = 0.0 //numberOfItems % 2 == 0 ? 8.0 : -8.0
		var usefulArea: CGFloat = usefulArea
		
		let leftInset: CGFloat = margin + (( frameWidth - ( frameWidth * usefulArea ) ) / 2)
		var itemSpacing: CGFloat = 0.0
		
		repeat {
			itemSpacing = (( frameWidth * usefulArea ) - ( CGFloat(numberOfItems) * itemWidth )) / CGFloat(numberOfItems - 1)
			usefulArea += 0.1
		} while itemSpacing < 0
		
		(self.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0)
		(self.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = itemSpacing
	}
	
	func proportionalItemSize(forNumberOfCells numberOfCells: Int, sizeRatio: CGFloat) -> CGSize {
		let spacingSize: CGFloat = (self.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0
		let sectionInset = (self.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? UIEdgeInsets.zero
		
		let contentWidth = self.frame.width - sectionInset.left - sectionInset.right
		
		let cellWidth = (( contentWidth - ( spacingSize * ( CGFloat(numberOfCells) + 1 ) ) ) / CGFloat(numberOfCells))
		let cellHeight = cellWidth * sizeRatio
		
		return CGSize(width: cellWidth, height: cellHeight)
	}
	
}
