//
//  MTipsCollectionObject.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

let tipIdentifier:String = "TIP_CELL"

class MTipsCollectionObject: NSObject, UICollectionViewDelegate, MTipsCollectionViewGestureDelegate
{
    //数据源，数据的入口，view 和 layOut都从这里拿数据，这里提供接口代理
    var tipsObjDataSource: MTipsDataSource!
    var collectionView: MTipsCollectionView!
    var collectionViewLayout: MTipsCollectionViewLayout!
    var tempMoveCell: MTipCell?
    var pressMoveCell: MTipCell?
    var moveFromIndex: NSInteger = -1
//    var moveToIndex: NSInteger = -1
    var pressMoveCellOffset: CGPoint = CGPointZero
    
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
        
        tipsObjDataSource = MTipsDataSource(itemCount: 8, configureBlock: configureCell)
        tipsObjDataSource.createDataArray()
        collectionViewLayout = MTipsCollectionViewLayout()
        collectionViewLayout.dataSource = tipsObjDataSource
        collectionView = MTipsCollectionView(frame: CGRectZero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = tipsObjDataSource
        collectionView.gestureDelegate = self
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
        println("------------------")
        for title in tipsObjDataSource.dataTitle
        {
            
            println(title)
        }
        println("-+++++++++++++")

        tipsObjDataSource.createDataArray()

        
        collectionView.moveItemAtIndexPath(NSIndexPath(forItem: fromCell, inSection: 0), toIndexPath: NSIndexPath(forItem: toCell, inSection: 0))
//        collectionView.reloadData()//这一句可以不需要
    }
    
    //collectionView gestureDelegate
    func tap(tapGesture: UITapGestureRecognizer) {
        println("点击")
        tipsObjDataSource.dataArray?.enumerateObjectsUsingBlock({object, index, stop in
            if let cellData = object as? MTipCellData
            {
                if CGRectContainsPoint(cellData.position, tapGesture.locationInView(self.collectionView))
                {
                    //点击cell事件
                    println("\(cellData.title)")
                }
            }
        })
    }
    func longPress(longPressGesture: UILongPressGestureRecognizer) {
//        println("长按")
        
        var position: CGPoint = longPressGesture.locationInView(collectionView)
        
        //  长按开始
        if longPressGesture.state == UIGestureRecognizerState.Began{
            tipsObjDataSource.dataArray?.enumerateObjectsUsingBlock({object, index, stop in
                if let cellData = object as? MTipCellData
                {
                    if CGRectContainsPoint(cellData.position, position)
                    {
                        //点击cell事件
//                        println("\(cellData.title)")
                        self.tempMoveCell = MTipCell(frame: cellData.position)
                        self.tempMoveCell!.configureCell(cellData)
                        self.collectionView.addSubview(self.tempMoveCell!)
                        
                        //点击放大
                        var transform = CGAffineTransformMakeScale(1.5, 1.5)
                        self.tempMoveCell!.transform = transform
                        
                        self.moveFromIndex = cellData.index
//                        self.moveToIndex = self.moveFromIndex
                        
                        //隐藏点击的cell
                        self.pressMoveCell = self.collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: self.moveFromIndex, inSection: 0)) as? MTipCell
                        self.pressMoveCell!.hidden = true
                
                        
                        //得出偏差
                        self.pressMoveCellOffset = CGPointMake(position.x - CGRectGetMidX(cellData.position), position.y - CGRectGetMidY(cellData.position))
                    }
                }
            })
        }
        
        //长按过程中
        if longPressGesture.state == UIGestureRecognizerState.Changed{
            self.tempMoveCell?.center = CGPointMake(position.x - self.pressMoveCellOffset.x, position.y - self.pressMoveCellOffset.y)
            tipsObjDataSource.dataArray?.enumerateObjectsUsingBlock({object, index, stop in
                if let cellData = object as? MTipCellData
                {
                    if CGRectContainsPoint(cellData.position, position)
                    {
                        if cellData.index != self.moveFromIndex
                        {
                            println("移动 \(self.moveFromIndex) 到 \(cellData.index)")
                            self.moveCellTo(fromCell: self.moveFromIndex, toCell: cellData.index)
                            self.moveFromIndex = cellData.index
                        }
                    }
                }
            })
            
        }
        
        if longPressGesture.state == UIGestureRecognizerState.Ended
        || longPressGesture.state == UIGestureRecognizerState.Cancelled
        || longPressGesture.state == UIGestureRecognizerState.Failed
        {
            self.tempMoveCell?.removeFromSuperview()
            self.tempMoveCell = nil
            //隐藏点击的cell
            self.pressMoveCell = self.collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: self.moveFromIndex, inSection: 0)) as? MTipCell
            self.pressMoveCell!.hidden = false
        }
    }
}






