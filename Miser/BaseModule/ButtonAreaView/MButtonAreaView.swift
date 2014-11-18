//
//  MButtonAreaView.swift
//  Miser
//
//  Created by 马权 on 11/15/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

class MButtonAreaView: UIView {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    
    /**
    基础配置
    */
    func baseConfigure()
    {
        self.backgroundColor = UIColor.redColor()
        addButton.primaryStyle()
        addButton.addAwesomeIcon(FAIconEdit, beforeTitle: false)
        
        checkButton.primaryStyle()
        checkButton.addAwesomeIcon(FAIconFile, beforeTitle: false)
    }
}
