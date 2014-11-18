//
//  MTipsCollectionView.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

class MTipsCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = UIColor.grayColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
