//
//  EAPMainTableViewController.swift
//  ExamAnki
//
//  Created by trainer on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPMainTableViewController: EAPAbstractTableViewController {
    let paperType:String
    var papers:[PaperInfo] {
        get {
            return EAPPaperManager.getOnePaperCategory(paperType)
        }
    }
    var paperNames:[String] {
        get {
        //  let papers = EAPPaperManager.getOnePaperCategory(paperType)
          return EAPPaperManager.getPaperNamesFromPapers(papers)
        }
    }
   override func getPapers() -> [PaperInfo] {
     return papers
    }
   // let papers = EAPPaperManager.getOnePaperCategory()
    //var paperNames = EAPPaperManager.getPaperNamesFromPapers(papers)
    init(paperType:String) {
      self.paperType = paperType
      super.init()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  paperNames.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell?.textLabel?.text = paperNames[indexPath.row]
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("seleted")
        
    }
}
