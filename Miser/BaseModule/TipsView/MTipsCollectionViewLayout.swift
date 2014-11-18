//
//  MTipsCollectionViewLayout.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

protocol TipsCVLayoutDelegate{
    func getCellBaseData(#index: Int) -> CellDataProtocol?
}

class MTipsCollectionViewLayout: UICollectionViewLayout {
    
    var cellCount: Int!
    var tipsCVDelegate: TipsCVLayoutDelegate!
    
    override func prepareLayout()
    {
        super.prepareLayout()
        cellCount = self.collectionView?.numberOfItemsInSection(0)
    }
    override func collectionViewContentSize() -> CGSize
    {
        return self.collectionView!.frame.size
    }
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]?
    {
        var attributes = NSMutableArray()
        for(var i = 0; i < cellCount; i++)
        {
            var indexPath = NSIndexPath(forItem: i, inSection: 0)
            attributes.addObject(self.layoutAttributesForItemAtIndexPath(indexPath))
        }
        return attributes
    }
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes!
    {
        var attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        //在这里设置单个attribute的数据
        var cellData = self.tipsCVDelegate.getCellBaseData(index: indexPath.item)
        attribute.frame = cellData!.frame
        
        return attribute
    }

}