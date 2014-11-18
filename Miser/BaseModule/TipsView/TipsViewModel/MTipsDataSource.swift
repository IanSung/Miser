//
//  MTipsDataSource.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

//  这里是数据进入的地方。 向外提供接口，查找数据。
/*
    ** dataSource 不负责设置东西，只负责从数据中提取所需要的部分，供外面使用。**
*/

import UIKit

let cellHeight: CGFloat = 36
let rowHeight: CGFloat = 44.0
let cellGap:CGFloat = 4.0

class MTipsDataSource: NSObject, UICollectionViewDataSource, TipsCVLayoutDataSource {
    var dataCount: Int!
    var dataArray: NSMutableArray?
    var configureBlock: (cell: AnyObject, cellData: AnyObject) -> Void!
    
    var dataTitle: [NSString] = []//暂时性虚假数据，整整dataSource不关心真是数据，只要放在array就行
    init(itemCount: Int, configureBlock: (cell: AnyObject, cellData: AnyObject) -> Void)
    {
        self.dataCount = itemCount
        self.configureBlock = configureBlock
        
        //假数据
        dataTitle = ["1", "22", "333", "4444", "55555","666666", "7777777", "8888888", "wwww","s", "sfdsafsdf", "ggg", "xi", "xiao", "er", "wwww","s", "232", "ggg","safdsfsdafsdaf"];
    }
    
    //创建数据的过程。
    func createDataArray()
    {
        if dataArray?.count > 0
        {
            dataArray!.removeAllObjects()
        }
        dataArray = NSMutableArray()
        for index in 0 ..< dataCount
        {
            var lastTipData: MTipCellData?;
            if index > 0
            {
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
            var size: CGSize = title.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(16.0)])
            size = CGSizeMake(size.width + currentData.baseWidth, size.height)//size从文字的长度，转成cell的长度
            var currentCellWidth = size.width + cellGap * 2
            if  currentCellWidth + lastCellMaxX < 280
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
    
    /*下面是对外的接口。 供外面调用*/
    
    //这个提供给layOut，layOut只关心CellDataProtocol的数据
    func getCellBaseData(#index: Int) -> CellLayoutDataProtocol? {
        return getCellData(index: index) as? CellLayoutDataProtocol
    }
    
    //下面的提供给view，view关系数量和每个cell
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
