//
//  EAPAbstractTableViewController.swift
//  ExamAnki
//
//  Created by trainer on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPAbstractTableViewController: NSObject,UITableViewDelegate,UITableViewDataSource {

    class func createTableViewController() -> EAPAbstractTableViewController {
        
        return EAPMainTableViewController()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        fatalError()
    }
}
