//
//  EAPAbstractTableViewController.swift
//  ExamAnki
//
//  Created by trainer on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPAbstractTableViewController:NSObject, UITableViewDelegate,UITableViewDataSource {

    
//    let paperType = ""
//    var papers = [PaperInfo]()
//    var paperNames = [String]()
    class func createTableViewController(paperType: String) -> EAPAbstractTableViewController {
        
        return EAPMainTableViewController(paperType: paperType)
    }
    func getPapers() -> [PaperInfo] {
        fatalError()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        fatalError()
    }
}
