//
//  EAQuestionTypeViewController.swift
//  ExamAnki
//
//  Created by trainer on 3/21/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAQuestionTypeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
let bookType = ["单选题","多选题","判断题","综合题"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bookType.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionTypeCell")
        cell?.textLabel?.text = bookType[indexPath.row]
        return cell!
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.hidesBottomBarWhenPushed = true
    }
    
    

}
