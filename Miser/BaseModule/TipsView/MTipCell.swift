//
//  MTipCell.swift
//  Miser
//
//  Created by 马权 on 11/16/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

class MTipCell: UICollectionViewCell {
    
    var titleLabel: UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1;
        var x:CGFloat = CGFloat(arc4random()) % 255 / 255
        var y:CGFloat = CGFloat(arc4random()) % 255 / 255
        var z:CGFloat = CGFloat(arc4random()) % 255 / 255
        self.backgroundColor = UIColor(red: x, green: y, blue: z, alpha: 1)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(cellData: MTipCellData!)
    {
        self.layer.cornerRadius = 8
        titleLabel = UILabel(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        titleLabel?.font = UIFont.systemFontOfSize(16.0)
        titleLabel?.textAlignment = NSTextAlignment.Center
        titleLabel?.text = cellData.title
        self.contentView.addSubview(titleLabel!)
    }
}
