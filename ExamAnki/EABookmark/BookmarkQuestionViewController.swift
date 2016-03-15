//
//  BookmarkQuestionViewController.swift
//  ExamAnki
//
//  Created by ZhouLiang on 2/24/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit
import CoreData

class BookmarkQuestionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let coreDataStack = CoreDataStack.sharedCoreDataStack
    var questions: Question!
    
    var single = [Question]()
    var multiple:Question!
    var alternative:Question!
    var general:Question!
    
    let bookType = ["单选题","多选题","判断题","综合题"]
    var sin = 0,mul = 0,alt = 0,gen = 0

    @IBOutlet weak var bookTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let fetch = NSFetchRequest(entityName: "Question")
        let predSingle1 = NSPredicate(format:"typecode == %@", "11")
        
        fetch.predicate = predSingle1
        do {
            let singleArr = try coreDataStack.mainQueueContext.executeFetchRequest(fetch)
            print("single-----\(singleArr.count)-----")
            
            for singleQuestion in singleArr {

                var singleAnswers = Set<QuestionOption>()
                
                let tempQuestion = singleQuestion as! Question
                print("singleOptions-----\(tempQuestion.options?.count)-----")

        
                let fetch = NSFetchRequest(entityName: "QuestionOption")
                fetch.predicate =
                    NSPredicate(format:"question == %@", tempQuestion)
                do {
                    let answers = try coreDataStack.mainQueueContext.executeFetchRequest(fetch)
                    print("answers-----\(answers.count)-----")
                    
                    for ans in answers {
                        let tempAnswer = ans as! QuestionOption
                        singleAnswers.insert(tempAnswer)
                    }
                }catch{
                    print(error)
                }
                
                tempQuestion.options = singleAnswers
                
                let count = single.count
                single.insert(tempQuestion, atIndex: count)
                
                for option in tempQuestion.options!{
                    let op = option as! QuestionOption
                    print(tempQuestion.sort!,tempQuestion.title!,"answer:\(tempQuestion.answer!)",op.sort!,op.content!)
                }
            }
        }catch{
            print(error)
        }
        print(single.count)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookType.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("BookmarkCell", forIndexPath: indexPath) as! BookmarkCell
        
        // 1
        let text = "\(bookType[indexPath.row])(\(single.count))" as NSString
        let attributedString = NSMutableAttributedString(string: text as String)
        
        // 2
        let firstAttributes = [NSForegroundColorAttributeName: UIColor.redColor(), NSBackgroundColorAttributeName: UIColor.clearColor(), NSUnderlineStyleAttributeName: 1]
        
        // 3
        attributedString.addAttributes(firstAttributes, range: text.rangeOfString("\(single.count)"))
        
        // 4
        cell.bookStyleLabel.attributedText = attributedString
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setScoreLblValue(value:Int) {


    }
    
    
    @IBAction func doAgain(sender: AnyObject) {
        
//        let controller = EARedoViewController()
//        
//        controller.hidesBottomBarWhenPushed = true
//        controller.title = "单选题"
//        controller.single = self.single
//        controller.setScoreLblValue = setScoreLblValue

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! EARedoViewController
        
        controller.hidesBottomBarWhenPushed = true
        controller.title = "单选题"
        controller.single = self.single
        controller.setScoreLblValue = setScoreLblValue
    }

    
    @IBAction func lookThrough(segue: UIStoryboardSegue,sender: AnyObject) {
        
    }
    
    
    
    
    
}
