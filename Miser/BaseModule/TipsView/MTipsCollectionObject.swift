//
//  MTipsCollectionObject.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

let tipIdentifier:String = "TIP_CELL"

class MTipsCollectionObject: NSObject, UICollectionViewDelegate
{
    //数据源，数据的入口，view 和 layOut都从这里拿数据，这里提供接口代理
    var tipsObjDataSource: MTipsDataSource!
    var collectionView: MTipsCollectionView!
    var collectionViewLayout: MTipsCollectionViewLayout!
    
    func showInView(#view: UIView){
        collectionView.frame = CGRectMake(20, 40, view.frame.size.width - 40, 132)
        view.addSubview(collectionView)
    }
    
    override init()
    {
        super.init()
        func configureCell(cell: AnyObject, cellData: AnyObject) -> Void{
            if let mCell = cell as? MTipCell{
                if let mCellData = cellData as? MTipCellData
                {
                    mCell.configureCell(mCellData)
                }
            }
        }
        
        tipsObjDataSource = MTipsDataSource(itemCount: 20, configureBlock: configureCell)
        tipsObjDataSource.createDataArray()
        collectionViewLayout = MTipsCollectionViewLayout()
        collectionViewLayout.dataSource = tipsObjDataSource
        collectionView = MTipsCollectionView(frame: CGRectZero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = tipsObjDataSource
        collectionView.registerClass(MTipCell.self, forCellWithReuseIdentifier: tipIdentifier)
    }
    
    func addCell(){
    
    }
    
    func deleteCell(#index: Int){
        
    }
    
    func moveCellTo(#fromCell: Int, toCell: Int){
        var temp = tipsObjDataSource.dataTitle[fromCell]
        tipsObjDataSource.dataTitle.removeAtIndex(fromCell)
        tipsObjDataSource.dataTitle.insert(temp, atIndex: toCell)
        tipsObjDataSource.createDataArray()
        collectionView.moveItemAtIndexPath(NSIndexPath(forItem: fromCell, inSection: 0), toIndexPath: NSIndexPath(forItem: toCell, inSection: 0))
        collectionView.reloadData()
    }
}






