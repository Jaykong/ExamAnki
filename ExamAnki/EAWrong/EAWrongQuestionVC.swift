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
    var question = [Question]()
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.navigationItem.title = "我的错题"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        question = EAQuestionManager.getQuestionsWithTypeCode(.choiceQuestion)!
//        print(question)
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
       
        cell.titleLabel!.attributedText = attributedStringChange(indexPath)
        
        return cell
    }
    func attributedStringChange(indexPath: NSIndexPath) -> NSMutableAttributedString {
        let text = "\(context[indexPath.row])(\(question.count))" as NSString
        let attributedString = NSMutableAttributedString(string: text as String)
        let fristString = [NSForegroundColorAttributeName: UIColor.redColor(), NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSUnderlineColorAttributeName: 1]
        attributedString.addAttributes(fristString, range:text.rangeOfString("\(question.count)"))
        
        return attributedString
    }
    private func optionsForContext() {
        for op in context {
            if op == "单选题" {
                
            }
        }
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
