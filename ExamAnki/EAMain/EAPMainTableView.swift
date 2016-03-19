//
//  EAPMainTableView.swift
//  ExamAnki
//
//  Created by trainer on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPMainTableView: EAPAstractMainTableView

{
    let tableViewController:EAPAbstractTableViewController = EAPAbstractTableViewController.createTableViewController()
    override init(frame: CGRect, style: UITableViewStyle) {
     
        super.init(frame: frame, style: style)
        self.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.delegate = tableViewController
        self.dataSource = tableViewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
