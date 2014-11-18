//
//  MTipsDataSource.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

let cellHeight: CGFloat = 36
let rowHeight: CGFloat = 44.0
let cellGap:CGFloat = 4.0

class MTipsDataSource: NSObject, UICollectionViewDataSource, TipsCVLayoutDelegate {
    var count: Int!
    var dataArray: NSMutableArray?
    var dataTitle: [NSString] = []
    var configureBlock: (cell: AnyObject, cellData: AnyObject) -> Void!
    init(itemCount: Int, configureBlock: (cell: AnyObject, cellData: AnyObject) -> Void)
    {
        self.count = itemCount
        self.configureBlock = configureBlock
        
        dataTitle = ["1", "22", "333", "4444", "55555","666666", "7777777", "8888888", "wwww","s", "sfdsafsdf", "ggg", "xi", "xiao", "er", "wwww","s", "232", "ggg","safdsfsdafsdaf"];
    }
    
    func createDataArray()
    {
        if dataArray?.count > 0
        {
            dataArray!.removeAllObjects()
        }
        dataArray = NSMutableArray()
        for index in 0 ..< count{
            var lastTipData: MTipCellData?;
            if index > 0{
                lastTipData = self.dataArray?[index - 1] as? MTipCellData
            }
            var lastCellMaxX: CGFloat = 0.0
            if lastTipData != nil
            {
                lastCellMaxX = CGRectGetMaxX(lastTipData!.position)
            }
        
            var currentData: MTipCellData = MTipCellData()
            
            //计算文字长度
            var title:NSString = dataTitle[index]
            let size: CGSize = title.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(16.0)])
            
            var currentCellWidth = size.width + cellGap * 2
            if  currentCellWidth + lastCellMaxX + cellGap * 2 < 280
            {
                if let temp = lastTipData?
                {
                    currentData.position = CGRectMake(lastCellMaxX + cellGap , lastTipData!.position.origin.y, currentCellWidth, cellHeight)
                }
                else{
                    currentData.position = CGRectMake(lastCellMaxX + cellGap, cellGap, currentCellWidth, cellHeight)
                }
            }
            else{
                if let temp = lastTipData?
                {
                    currentData.position = CGRectMake(cellGap, lastTipData!.position.origin.y + rowHeight, currentCellWidth, cellHeight)
                }
                else{
                    currentData.position = CGRectMake(cellGap, cellGap, currentCellWidth, cellHeight)
                }

            }
            currentData.title = title
            self.dataArray!.addObject(currentData)
        }
        
    }

    func getCellData(#index: Int) -> AnyObject!{
        return dataArray![index]
    }
    
    func getCellBaseData(#index: Int) -> CellDataProtocol? {
        return getCellData(index: index) as? CellDataProtocol
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataArray!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell:MTipCell = collectionView.dequeueReusableCellWithReuseIdentifier(tipIdentifier, forIndexPath: indexPath) as MTipCell
        self.configureBlock(cell: cell, cellData: getCellData(index: indexPath.item))
        return cell
    }

}
