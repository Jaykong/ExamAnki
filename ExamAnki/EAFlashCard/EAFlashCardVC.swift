//
//  ViewController.swift
//  TableViewNodes
//
//  Created by zxz on 16/3/20.
//  Copyright © 2016年 zxz. All rights reserved.
//

import UIKit

let cell_1_Identifier = "cell1"
class EAFlashCarVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var tableview:UITableView!
    var rowCount:Int!
    //    var objects = []
    var tempIndex:NSIndexPath!
    
    
    private var dataDictionary = NSMutableDictionary()
    var keys:NSArray{
        get {
            return dataDictionary.allKeys
        }
    }
    
    override func loadView() {
        super.loadView()
        dataDictionary = ["Objective-C":["easy","hard","good","wrong"],"JavaScript":["easy","hard","good","wrong"],"Python":["easy","hard","good","wrong"]]
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tableview = UITableView(frame: self.view.frame, style: .Grouped)
        self.view.addSubview(tableview)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        
        
    }
    
    func dictionary(aDictonary:NSMutableDictionary,addObjects objects:Array<AnyObject>,forKey key:String) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //        print("numberOfSectionsInTableView\(self.context++)")
        return self.keys.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        let key = dataDictionary.allKeys[section] as! String
        //        let objects = dataDictionary[key]
        let header = tableview.headerViewForSection(section) as? XZHeaderView
        if header != nil && header!.isTapped == true {
            let key = self.keys[section] as! String
            return (dataDictionary[key]?.count)!
        }
        
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cell_1_Identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cell_1_Identifier)
        }
        let key = self.keys[indexPath.section] as? String
        let text = dataDictionary[key!]![indexPath.row] as! String
        cell?.textLabel?.text = "第\(indexPath.section)列:\(indexPath.row)行:" + text
        return cell!;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = XZHeaderView(reuseIdentifier: "header")
        view.section = section
        view.contentView.backgroundColor = UIColor.greenColor()
        view.textLable.text = self.keys[section] as? String
        view.textLable.textAlignment = .Center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EAFlashCarVC.tapHeaderView(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }
    //MARK:tap
    func tapHeaderView(sender:UIGestureRecognizer){
        print("tapHeaderView")
        
        let view = sender.view as! XZHeaderView
        let section = view.section
        var indexPaths = [NSIndexPath]()
        let key = self.keys[section] as! String
        let count = dataDictionary[key]?.count
       
        for i in 0..<count! {
            let index = NSIndexPath(forRow: i, inSection: section)
            indexPaths.append(index)
        }
        
        if view.isTapped == false {
            view.isTapped = true
            
            self.tableview.insertRowsAtIndexPaths(indexPaths, withRowAnimation:.Middle)
            
        }else{
            view.isTapped = false
            self.tableview.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
            
        }
        
    }
    //MARK: tableview delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        //        let cell = tableview.cellForRowAtIndexPath(indexPath)
        //        let identifier = cell?.reuseIdentifier
        //        print(identifier)
        //
        //
        //        tableview.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        //        tableview.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Automatic)
        
        
    }
    
    func tableView(tableView:UITableView, insertRowAtIndexPath indexPath:NSIndexPath, cellIdentifier:String, withData data:Array<AnyObject>){
        
    }
    
    
}

