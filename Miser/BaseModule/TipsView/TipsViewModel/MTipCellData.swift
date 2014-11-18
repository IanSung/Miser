//
//  MTipCellData.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

@objc protocol CellDataProtocol{
    var frame: CGRect { get }
}

class MTipCellData: NSObject, CellDataProtocol {
    
    var title: String!
    
    var position: CGRect = CGRectZero
    
    override init()
    {
        super.init()
    }
    var frame: CGRect{
        return position
    }
}
