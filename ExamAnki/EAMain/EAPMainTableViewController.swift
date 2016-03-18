//
//  EAPMainTableViewController.swift
//  ExamAnki
//
//  Created by trainer on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPMainTableViewController: EAPAbstractTableViewController,UITableViewDelegate,UITableViewDataSource {
    var paperNames = EAPPaperManager.getPaperNamesFromPapers()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  paperNames.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell?.textLabel?.text = paperNames[indexPath.row]
        return cell!
        
    }
}
