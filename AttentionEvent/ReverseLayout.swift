//
//  ReverseLayout.swift
//  AttentionEvent
//
//  Created by VuVince on 1/30/18.
//  Copyright © 2018 VuVince. All rights reserved.
//

import UIKit

class ReverseLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if collectionView?.bounds.size.width != newBounds.width || collectionView?.bounds.size.height != newBounds.height {
            return true
        }
        return super.shouldInvalidateLayout(forBoundsChange: newBounds)
    }

    override func layoutAttributesForElements(in reversedRect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let normalRect = reverse(rect: reversedRect)
        guard let atts = super.layoutAttributesForElements(in: normalRect) else { return nil }
        var newAtts = [UICollectionViewLayoutAttributes]()
        for att in atts {
            let newAtt = modify(attributes: att)
            newAtts.append(newAtt)
        }
        return newAtts
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let att = super.layoutAttributesForItem(at: indexPath) else {
            return nil
        }
        return modify(attributes: att)
    }
    
    override var scrollDirection: UICollectionViewScrollDirection {
        didSet {
            assert(scrollDirection == .vertical, "horizontal scrolling is not supported")
        }
    }
    
    func modify(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let normalCenter = attributes.center
        let newAtt = attributes.copy() as! UICollectionViewLayoutAttributes
        newAtt.center = reverseX(center: reverseY(center: normalCenter))
        return newAtt
    }
    
    func reverse(rect: CGRect) -> CGRect {
        let reverseBottomLeft = reverseY(center: rect.origin)
        return CGRect(x: reverseBottomLeft.x, y: reverseBottomLeft.y - rect.height, width: rect.width, height: rect.height)
    }
    
    func reverseY(center: CGPoint) -> CGPoint {
        let contentSize = super.collectionViewContentSize
        return CGPoint(x: center.x, y: contentSize.height - center.y)
    }
    
    func reverseX(center: CGPoint) -> CGPoint {
        let contentSize = super.collectionViewContentSize
        return CGPoint(x: contentSize.width - center.x, y: center.y)
    }
    
}
