//
//  MButtonAreaView.swift
//  Miser
//
//  Created by 马权 on 11/15/14.
//  Copyright (c) 2014 maquan. All rights reserved.
//

import UIKit

protocol MButtonAreaViewDelegate{
    func addTip(sender: UIButton) -> Void
    func deleteTip(sender: UIButton) -> Void
}

class MButtonAreaView: UIView {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    var delegate: MButtonAreaViewDelegate?
    
    /**
    基础配置
    */
    func baseConfigure()
    {
        self.backgroundColor = UIColor.redColor()
        addButton.primaryStyle()
        addButton.addAwesomeIcon(FAIconEdit, beforeTitle: false)
        addButton.addTarget(self, action: "addTip:", forControlEvents: UIControlEvents.TouchUpInside)
        
        checkButton.primaryStyle()
        checkButton.addAwesomeIcon(FAIconFile, beforeTitle: false)
        checkButton.addTarget(self, action: "deleteTip:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func addTip(sender: UIButton) -> Void{
        self.delegate!.addTip(sender)
    }
    
    func deleteTip(sender: UIButton) -> Void{
        self.delegate!.deleteTip(sender)
    }
}
