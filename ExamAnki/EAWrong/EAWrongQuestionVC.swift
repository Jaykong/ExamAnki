//
//  EAWrongQuestionVC.swift
//  ExamAnki
//
//  Created by XinJinquan on 3/2/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAWrongQuestionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let context = ["单选题", "多选题", "判断题", "综合题"]
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.navigationItem.title = "我的错题"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return context.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EAWrongQestionCell", forIndexPath: indexPath)
            as! EAWrongQuestionVCCell
        
        cell.titleLabel!.text = context[indexPath.row]
        
        
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
