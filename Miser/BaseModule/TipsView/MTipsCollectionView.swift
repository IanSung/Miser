//
//  MTipsCollectionView.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

protocol MTipsCollectionViewGestureDelegate{
    func longPress(longPressGesture: UILongPressGestureRecognizer) -> Void
    func tap(tapGesture: UITapGestureRecognizer) -> Void
}

class MTipsCollectionView: UICollectionView {
    
    var longPressGesture: UILongPressGestureRecognizer?
    var tapGesture: UITapGestureRecognizer?
    var gestureDelegate: MTipsCollectionViewGestureDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor.grayColor()
        //初始化手势
        longPressGesture = UILongPressGestureRecognizer(target: self, action: "longPress:")
        self.addGestureRecognizer(longPressGesture!)
        tapGesture = UITapGestureRecognizer(target: self, action: "tap:")
        self.addGestureRecognizer(tapGesture!)
    }

    func longPress(gesture: UILongPressGestureRecognizer) -> Void {
        gestureDelegate?.longPress(gesture)
    }
    
    func tap(gesture: UITapGestureRecognizer) -> Void {
        gestureDelegate?.tap(gesture)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
