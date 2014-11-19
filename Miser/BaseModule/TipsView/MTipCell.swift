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

    var titleLabel: UILabel?
    var tipImageView: UIImageView?
    var data: MTipCellData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1;
        var x:CGFloat = CGFloat(arc4random()) % 255 / 255
        var y:CGFloat = CGFloat(arc4random()) % 255 / 255
        var z:CGFloat = CGFloat(arc4random()) % 255 / 255
        self.backgroundColor = UIColor(red: x, green: y, blue: z, alpha: 1)
        data = MTipCellData()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  对外提供接口，拿到MTipCellData数据，进行cell内容的设置
    func configureCell(cellData: MTipCellData!)
    {
        data = cellData
        var tipImage = UIImage(named: "LaunchForXib.png")
        tipImageView = UIImageView(image: tipImage)
        tipImageView!.frame = CGRectMake(5, 0, 20, self.frame.size.height)
        self.contentView.addSubview(tipImageView!)
        
        self.layer.cornerRadius = 8
        titleLabel = UILabel(frame: CGRectMake(30, 0, self.frame.size.width, self.frame.size.height))
        titleLabel?.font = UIFont.systemFontOfSize(16.0)
        titleLabel?.textAlignment = NSTextAlignment.Left
        titleLabel?.text = cellData.title
        self.contentView.addSubview(titleLabel!)
    }
}
