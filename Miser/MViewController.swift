//
//  ViewController.swift
//  Miser
//
//  Created by 马权 on 14/11/9.
//  Copyright (c) 2014年 maquan. All rights reserved.
//

import UIKit

class MViewController: UIViewController
{
    @IBOutlet var buttonArea: MButtonAreaView!
    var tipsCollectionObj: MTipsCollectionObject!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        SYAppStart.show()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        SYAppStart.hide(true)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        baseConfigure()
        createTipsArea()
        createButtonArea()
        
        var btn = UIButton(frame: CGRectMake(20, CGRectGetMaxY(tipsCollectionObj.collectionView.frame), 100, 44))
        btn.backgroundColor = UIColor.redColor()
        btn.addTarget(self, action: "baseConfigure", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
    }
    
    func baseConfigure(){
        tipsCollectionObj.moveCellTo(fromCell: 1, toCell: 3)
    }
    
    func createTipsArea(){
        tipsCollectionObj = MTipsCollectionObject()
        tipsCollectionObj.showInView(view: self.view)
    }
    
    /**
    创建按键区 xib
    */
    func createButtonArea(){
        NSBundle.mainBundle().loadNibNamed("MButtonAreaView", owner: self, options: nil)[0]
        buttonArea.frame = CGRectMake(0, view.frame.size.height - 84, view.frame.size.width, 84)
        buttonArea.baseConfigure()
        self.view.addSubview(buttonArea)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}





























