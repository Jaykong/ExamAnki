//
//  EAPAstractMainTableView.swift
//  ExamAnki
//
//  Created by trainer on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPAstractMainTableView: UITableView {
    class func createMainTableView(controller:EAPAbstractTableViewController) -> EAPAstractMainTableView {
    let tableview =  EAPMainTableView.init(frame: CGRectZero, style: .Plain,tableViewController:controller)
       //let controller =  EAPMainTableViewController()
       // tableview.delegate = controller
       // tableview.dataSource = controller
       
     return tableview
    }
}
