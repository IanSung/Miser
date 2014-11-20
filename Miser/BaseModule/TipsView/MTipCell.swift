//
//  MTipCell.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

//  cell视图类
/*
    所有视图样式一致，初始化时，初始共有信息
*/
//  cell 5(gap) + 20(tipImage) + 5(gap) + ...(title) + 5(gap)

import UIKit

class MTipCell: UICollectionViewCell {

    @IBOutlet weak var tipImageView: UIImageView!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var data: MTipCellData?
    
    //  cell代码初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor.clearColor()
        data = MTipCellData()
    }

    //  cell xib 初始化
    required init(coder aDecoder: NSCoder) {
        //xib加载会走这里
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor.clearColor()
        data = MTipCellData()

    }
    
    //  对外提供接口，拿到MTipCellData数据，进行cell内容的设置
    func configureCell(cellData: MTipCellData!)
    {
        data = cellData
        bgView?.layer.borderWidth = 1
        bgView?.layer.cornerRadius = 8
        var x:CGFloat = CGFloat(arc4random()) % 255 / 255
        var y:CGFloat = CGFloat(arc4random()) % 255 / 255
        var z:CGFloat = CGFloat(arc4random()) % 255 / 255
        bgView?.backgroundColor = UIColor(red: x, green: y, blue: z, alpha: 1)
        
        var tipImage = UIImage(named: "LaunchForXib.png")
        tipImageView.image = tipImage
        
        titleLabel?.text = cellData.title
    }
}
