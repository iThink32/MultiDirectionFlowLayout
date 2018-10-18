//
//  MultiDirectionFlowLayout.swift
//  TestMultipleDirectionCollectionView
//
//  Created by N.A Shashank on 18/10/18.
//  Copyright © 2018 Razorpay. All rights reserved.
//

import UIKit

class MultiDirectionFlowLayout: UICollectionViewLayout {
    
    @IBInspectable var columnWidth:CGFloat = 150
    @IBInspectable var rowWidth:CGFloat = 320
    @IBInspectable var cellHeight:CGFloat = 50
    
    var arrLayoutAttributes = [IndexPath:UICollectionViewLayoutAttributes]()
    
    var contentSize = CGSize.zero
    
    var isDataSourceUpdated = false
    
    override var collectionViewContentSize: CGSize{
        return self.contentSize
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else{
            assertionFailure("could not get collection view")
            return
        }
        // initially position all cells property
        guard self.isDataSourceUpdated == false else{
            // once you have posioned cells properly only make changes to the sticky cells
            let xOffset = collectionView.contentOffset.x
            let yOffset = collectionView.contentOffset.y
            
            for section in 0..<collectionView.numberOfSections {
                // if it is the first section make the first cell stick where it is and the others flow horizontally but not vertically
                guard section == 0 else{
                    // for other cells just make sure that the first cell sticks where it is
                    let indexPath = IndexPath(item: 0, section: section)
                    guard let cellAttributes = self.arrLayoutAttributes[indexPath] else{
                        continue
                    }
                    cellAttributes.frame.origin.x = xOffset
                    continue
                }
                for item in 0..<collectionView.numberOfItems(inSection: 0) {
                    let indexPath = IndexPath(item: item, section: section)
                    guard let cellAttributes = self.arrLayoutAttributes[indexPath] else{
                        continue
                    }
                    if item == 0 {
                        cellAttributes.frame.origin.x = xOffset
                    }
                    cellAttributes.frame.origin.y = yOffset
                }
            }
            return
        }
        var totalWidth:CGFloat = 0
        var totalHeight:CGFloat = 0
        // normal positioning
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let cellIndexPath = IndexPath(item: item , section: section)
                let frameCell = self.frameOfCellBasedOn(indexPath: cellIndexPath)
                let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndexPath)
                cellAttributes.frame = frameCell//CGRect(x: xPosition, y: yPosition, width: cellSize.width, height: cellSize.height)
                // first case - first cell is always above the rest
                if cellIndexPath.section == 0 && cellIndexPath.item == 0 {
                    cellAttributes.zIndex = 4
                }
                // second case - all cells in the first row other than the first have to be visible at all times on vertical scroll but has to go below the first row first cells on horizontal scroll that is why the z index is lower than the above one
                else if cellIndexPath.section == 0 && cellIndexPath.item > 0 {
                    cellAttributes.zIndex = 3
                }
                // third case - all first cells in sections other than the first must be visible always on horizonatal scroll but must go below the first cell on vertical scroll
                else if cellIndexPath.section > 0 && cellIndexPath.item == 0 {
                   cellAttributes.zIndex = 2
                }
                // other cells must go below the higher priority ones.
                else {
                    cellAttributes.zIndex = 1
                }
                self.arrLayoutAttributes[cellIndexPath] = cellAttributes
            }
        }
        
        // update content size
        totalWidth = columnWidth + (CGFloat(collectionView.numberOfItems(inSection: 0) - 1) * rowWidth )
        totalHeight = cellHeight * CGFloat(collectionView.numberOfSections)
        
        self.contentSize.width = totalWidth
        self.contentSize.height = totalHeight
        self.isDataSourceUpdated = true
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.arrLayoutAttributes[indexPath]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var arrLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for (_,attributes) in self.arrLayoutAttributes where rect.intersects(attributes.frame) {
            arrLayoutAttributes.append(attributes)
        }
        return arrLayoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func frameOfCellBasedOn(indexPath:IndexPath) -> CGRect {
        var frame = CGRect.zero
        switch indexPath {
        case let indexPath where indexPath.item == 0 :
            frame = CGRect(x: 0, y: (CGFloat(indexPath.section) * cellHeight), width: columnWidth, height: cellHeight)
        default :
            let xPosition = self.columnWidth + (CGFloat(indexPath.item - 1) * rowWidth)
            frame = CGRect(x: xPosition, y: CGFloat(indexPath.section)  * cellHeight, width: rowWidth, height: cellHeight)
        }
        return frame
    }
    
    

}
