//
//  MTipCellData.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

//这个接口提供给
@objc protocol CellLayoutDataProtocol{
    var frame: CGRect { get }
    var baseWidth: CGFloat { get }
}

//  每个tip所含有的数据
/*
    1.  tip的字符内容
    2.  tip的位置信息
    3.  tip所含的图片编号
*/
class MTipCellData: NSObject, CellLayoutDataProtocol {
    
    var index: Int!
    
    var title: String!
    
    var position: CGRect = CGRectZero

    override init()
    {
        super.init()
    }
    var frame: CGRect{
        return position
    }
    var baseWidth: CGFloat{
        return 35.0
    }
}
