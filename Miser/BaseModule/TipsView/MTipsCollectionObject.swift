//
//  MTipsCollectionObject.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

let tipIdentifier:String = "TIP_CELL"

class MTipsCollectionObject: NSObject, UICollectionViewDelegate, MTipsCollectionViewGestureDelegate {
    //数据源，数据的入口，view 和 layOut都从这里拿数据，这里提供接口代理
    var tipsObjDataSource: MTipsDataSource!
    var collectionView: MTipsCollectionView!
    var collectionViewLayout: MTipsCollectionViewLayout!
    var tempMoveCell: MTipCell?
    var pressMoveCell: MTipCell?
    var moveFromIndex: NSInteger = -1
    var pressMoveCellOffset: CGPoint = CGPointZero
  
    // 初始化一些数据
    override init() {
        super.init()
        func configureCell(cell: AnyObject, cellData: AnyObject) -> Void{
            if let mCell = cell as? MTipCell{
                if let mCellData = cellData as? MTipCellData{
                    mCell.configureCell(mCellData)
                }
            }
        }
        
        tipsObjDataSource = MTipsDataSource(configureBlock: configureCell, cellIndetifier: tipIdentifier)
        tipsObjDataSource.createDataArray()
        collectionViewLayout = MTipsCollectionViewLayout()
        collectionViewLayout.dataSource = tipsObjDataSource
        collectionView = MTipsCollectionView(frame: CGRectZero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = tipsObjDataSource
        collectionView.gestureDelegate = self
        //这种是用类加载，如果用类加载，就需要把一些相同的基础设置写入初始化中
//        collectionView.registerClass(MTipCell.self, forCellWithReuseIdentifier: tipIdentifier)
        
        //下面这种使用xib加载，可以用于加载相同的基础设置
        collectionView.registerNib(UINib(nibName: "MTipCell", bundle: nil), forCellWithReuseIdentifier: tipIdentifier)

    }
    
    //  显示
    func showInView(#view: UIView) {
        collectionView.frame = CGRectMake(20, 40, view.frame.size.width - 40, 132)
        view.addSubview(collectionView)
    }
    
    //  增加
    func addCell() {
        tipsObjDataSource.dataTitle.insert("456", atIndex: 0)
        tipsObjDataSource.createDataArray()
        collectionView.performBatchUpdates({
            self.collectionView.insertItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
            }, completion: {finish in
        })
    }
    
    //  删除
    func deleteCell(#index: Int) {
        tipsObjDataSource.dataTitle.removeAtIndex(0)
        tipsObjDataSource.createDataArray()
        collectionView.performBatchUpdates({
            self.collectionView.deleteItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
            }, completion: {finish in
        })

    }
    
    //  移动
    func moveCellTo(#fromCell: Int, toCell: Int) {
        var temp = tipsObjDataSource.dataTitle[fromCell]
        tipsObjDataSource.dataTitle.removeAtIndex(fromCell)
        tipsObjDataSource.dataTitle.insert(temp, atIndex: toCell)
        println("------------------")
        for title in tipsObjDataSource.dataTitle {
            
            println(title)
        }
        println("-+++++++++++++")
        tipsObjDataSource.createDataArray()
        collectionView.moveItemAtIndexPath(NSIndexPath(forItem: fromCell, inSection: 0), toIndexPath: NSIndexPath(forItem: toCell, inSection: 0))
    }
    
    //  collectionView gestureDelegate
    //  点击
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
    
    //  长按
    func longPress(longPressGesture: UILongPressGestureRecognizer) {
//        println("长按")
        
        var position: CGPoint = longPressGesture.locationInView(collectionView)
        
        //  长按开始
        if longPressGesture.state == UIGestureRecognizerState.Began {
            tipsObjDataSource.dataArray?.enumerateObjectsUsingBlock({object, index, stop in
                if let cellData = object as? MTipCellData {
                    if CGRectContainsPoint(cellData.position, position) {
                        //点击cell事件
//                        println("\(cellData.title)")
                        self.tempMoveCell = NSBundle.mainBundle().loadNibNamed("MTipCell", owner: self, options: nil)[0] as? MTipCell
                        self.tempMoveCell!.frame = cellData.position
                        self.tempMoveCell!.configureCell(cellData)
                        self.collectionView.addSubview(self.tempMoveCell!)
                        
                        //点击放大
//                        var transform = CGAffineTransformMakeScale(1.5, 1.5)
//                        self.tempMoveCell!.transform = transform
                        
                        self.moveFromIndex = cellData.index
                        
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
        if longPressGesture.state == UIGestureRecognizerState.Changed {
            self.tempMoveCell?.center = CGPointMake(position.x - self.pressMoveCellOffset.x, position.y - self.pressMoveCellOffset.y)
            tipsObjDataSource.dataArray?.enumerateObjectsUsingBlock({object, index, stop in
                if let cellData = object as? MTipCellData {
                    if cellData.index < self.moveFromIndex {
                        var frontHalfRect = CGRectMake(CGRectGetMinX(cellData.position), CGRectGetMinY(cellData.position), CGRectGetWidth(cellData.position) / 2, CGRectGetHeight(cellData.position))
                        
                        if CGRectContainsPoint(cellData.position, position)
                        {
                            // 如果进入前一半
                            if CGRectContainsPoint(frontHalfRect, position) {
                                self.moveCellTo(fromCell: self.moveFromIndex, toCell: cellData.index)
                                self.moveFromIndex = cellData.index
                            }
                            else {
                                self.moveCellTo(fromCell: self.moveFromIndex, toCell: cellData.index + 1)
                                self.moveFromIndex = cellData.index + 1
                            }

                        }
                    }
                    
                    if self.moveFromIndex < cellData.index {
                        var backHalfRect = CGRectMake(CGRectGetMidX(cellData.position), CGRectGetMinY(cellData.position), CGRectGetWidth(cellData.position) / 2, CGRectGetHeight(cellData.position))
                        
                        if CGRectContainsPoint(cellData.position, position) {
                            // 如果进入后一半
                            if CGRectContainsPoint(backHalfRect, position) {
                                self.moveCellTo(fromCell: self.moveFromIndex, toCell: cellData.index)
                                self.moveFromIndex = cellData.index
                            }
                            else {
                                self.moveCellTo(fromCell: self.moveFromIndex, toCell: cellData.index - 1)
                                self.moveFromIndex = cellData.index - 1
                            }

                        }
                    }
                }
            })
            
        }
        
        if longPressGesture.state == UIGestureRecognizerState.Ended
        || longPressGesture.state == UIGestureRecognizerState.Cancelled
        || longPressGesture.state == UIGestureRecognizerState.Failed {
            
            UIView.animateWithDuration(0.5, animations: {
                self.tempMoveCell!.frame = self.pressMoveCell!.frame
                //放手缩小
//                var transform = CGAffineTransformMakeScale(1, 1)
//                self.tempMoveCell!.transform = transform

            }, completion: {finish in
                self.tempMoveCell?.removeFromSuperview()
                self.tempMoveCell = nil
                //隐藏点击的cell
                self.pressMoveCell = self.collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: self.moveFromIndex, inSection: 0)) as? MTipCell
                self.pressMoveCell!.hidden = false
            })
            
        }
    }
}






