//
//  EAPScrollview.swift
//  ExamAnki
//
//  Created by trainer on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit
let EAScreenWidth = Int(UIScreen.mainScreen().bounds.size.width)
let EAScreenHeight = Int(UIScreen.mainScreen().bounds.size.height)

class EAPScrollview: EAPAbstractScrollview {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.contentView)
        for var i = 0;i < 3; ++i {
            let tableview = EAPAstractMainTableView.createMainTableView()
            self.contentView.addSubview(tableview)
        }
        
    }
    
    override func addTableViews() {
        for var i = 0;i < 3; ++i {
            let tableview = EAPAstractMainTableView.createMainTableView()
            //tableview.frame = CGRect(x: i * EAScreenWidth, y: 0, width:EAScreenWidth , height:Int(self.frame.size.height))
            self.addSubview(tableview)
            
        }
        
    }
    convenience init() {
        self.init(frame:CGRectZero)
        self.directionalLockEnabled = true
        self.pagingEnabled = true
        //self.contentSize = CGSize(width: 3 * EAScreenWidth, height: EAScreenHeight)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
