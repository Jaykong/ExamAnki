//
//  EAQuestionTVC.swift
//  ExamAnki
//
//  Created by trainer on 3/14/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAQuestionTVC: UITableViewController{
    
    var question:Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.style
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - register nib
    func registerForNib() {
        let nib = UINib(nibName: "EAQuestionTVCell", bundle: NSBundle.mainBundle())
        let nib1 = UINib(nibName: "EAAnswerTVCell", bundle: NSBundle.mainBundle())
        let nib2 = UINib(nibName: "EAReaultTVCell", bundle: NSBundle.mainBundle())
        let nib3 = UINib(nibName: "EAReferenceTVCell", bundle: NSBundle.mainBundle())
        let nib4 = UINib(nibName: "EAAnalysisTVCell", bundle: NSBundle.mainBundle())
        let nib5 = UINib(nibName: "EADefultTVCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(nib, forCellReuseIdentifier: "EAQuestionTVCell")
        tableView.registerNib(nib1, forCellReuseIdentifier: "EAAnswerTVCell")
        tableView.registerNib(nib2, forCellReuseIdentifier: "EAReaultTVCell")
        tableView.registerNib(nib3, forCellReuseIdentifier: "EAReferenceTVCell")
        tableView.registerNib(nib4, forCellReuseIdentifier: "EAAnalysisTVCell")
        tableView.registerNib(nib5, forCellReuseIdentifier: "EADefultTVCell")
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if question!.parse!.isEmpty {
            return 4
        }
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            return (question?.options?.count)!
        }
        
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("EAQuestionTVCell", forIndexPath: indexPath) as! EAQuestionTVCell
            cell.questionLbl?.text = "\(question.sort!)、\(question.title!)"
            cell.questionLbl?.numberOfLines = 0
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("EAAnswerTVCell", forIndexPath: indexPath) as! EAAnswerTVCell
            let sets = question?.options!
            let options = Array (sets!) as NSArray
            //  options.sortedArrayUsingSelector("caseInsensitiveCompare:")
            let sortDes = NSSortDescriptor(key: "sort", ascending: true)
            let newOptions = options.sortedArrayUsingDescriptors([sortDes])
            
            // question?.options
            let option = newOptions[indexPath.row] as! QuestionOption
            let title = option.content
            cell.answerLbl?.text = title
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("EAAnalysisTVCell", forIndexPath: indexPath) as! EAAnalysisTVCell
            cell.anslysisLbl?.text = "答对了"
            cell.anslysisLbl?.numberOfLines = 0
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("EAReaultTVCell", forIndexPath: indexPath) as! EAReaultTVCell
            cell.reaultLbl?.text = "参考答案 \(question.answer!)"
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("EAReferenceTVCell", forIndexPath: indexPath) as! EAReferenceTVCell
            if question?.parse == nil {
                cell.referenceLbl?.text = " "
            } else {
                cell.referenceLbl?.text = question?.parse
                
            }
            
            cell.referenceLbl?.numberOfLines = 0
            return cell
            
        default:
            //            let cell = tableView.dequeueReusableCellWithIdentifier("EADefultTVCell") as! EADefultTVCell
            //            cell.defultLbl!.text = "No answer!"
            //            return cell
            
            let cell = tableView.dequeueReusableCellWithIdentifier("EAReferenceTVCell", forIndexPath: indexPath) as! EAReferenceTVCell
            cell.referenceLbl?.text = question?.parse
            cell.referenceLbl?.numberOfLines = 0
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if ((question?.parse) == nil) {
            return 44
        } else {
            return UITableViewAutomaticDimension
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
