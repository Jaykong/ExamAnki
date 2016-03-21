//
//  EARedoViewController.swift
//  ExamAnki
//
//  Created by ZhouLiang on 3/2/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit
import CoreData

class EARedoVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
    
    let coreDataStack = CoreDataStack.sharedCoreDataStack
    
    var single = [Question]()
    var answer :QuestionOption!
    var userAns = [UserQuestionRecord]()
    
    var _scrollView:UIScrollView!
    var _tableView1:UITableView!
    var _tableView2:UITableView!
    var _tableView3:UITableView!
    
    var currentPage = 0
    var prePage = 0
    var nextPage = 0
    
    var reusedPage = 0
    var setScoreLblValue:((Int) -> Void)!
    
    func pageCheck(page:Int) ->Int {
        if page == -1 {
            return single.count - 1
        }
        if page >= single.count {
            return 0
        }
        return page
    }
    
    func initReusedPage(tableview:UITableView) {
        switch tableview {
        case _tableView1:
            
            prePage = pageCheck(prePage)
            reusedPage = prePage
        case _tableView2:
            
            currentPage = pageCheck(currentPage)
            reusedPage = currentPage
        case _tableView3:
            
            nextPage = pageCheck(nextPage)
            reusedPage = nextPage
        default:
            reusedPage = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
//        let fetchRequest = NSFetchRequest(entityName:EAUserQuestionRecord)
//        do {
//            let userAnwers = try coreDataStack.mainQueueContext.executeFetchRequest(fetchRequest)
//            print("answers-----\(userAnwers.count)-----")
//            
//            for uAn in userAnwers {
//                let temp = uAn as! UserQuestionRecord
//                let count = userAns.count
//                userAns.insert(temp, atIndex: count)
//            }
//        }catch{
//            print(error)
//        }
        
        self.navigationItem.backBarButtonItem?.title = "返回"
        
        let rightItem = UIBarButtonItem(title: "解析", style: UIBarButtonItemStyle.Done, target: self, action:"parseInPaper")
        self.navigationItem.rightBarButtonItem = rightItem
        
        
        let width = view.bounds.size.width
        let height =  view.bounds.size.height
        
        _scrollView = UIScrollView(frame: view.bounds)
        _scrollView.pagingEnabled = true
        
        _scrollView.contentSize = CGSizeMake(width * 3, height)
        
        _tableView1 = UITableView(frame: view.frame, style: UITableViewStyle.Plain)
        _tableView2 = UITableView(frame: view.frame, style: UITableViewStyle.Plain)
        _tableView3 = UITableView(frame: view.frame, style: UITableViewStyle.Plain)
        
        _tableView1!.frame = CGRectMake(0, 0, width, height)
        _tableView2!.frame = CGRectMake(width, 0, width, height)
        _tableView3!.frame = CGRectMake(2 * width ,0, width, height)
        
        _scrollView.delegate = self
        _tableView1.delegate = self
        _tableView1.dataSource = self
        
        _tableView2.delegate = self
        _tableView2.dataSource = self
        
        _tableView3.delegate = self
        _tableView3.dataSource = self
        
        _scrollView.addSubview(_tableView1)
        _scrollView.addSubview(_tableView2)
        _scrollView.addSubview(_tableView3)
        
        view.addSubview(_scrollView)
        
        
        
        _scrollView.bounces = false
        _scrollView.alwaysBounceVertical = false
        
        self.edgesForExtendedLayout = UIRectEdge.Bottom
        
        _scrollView.contentOffset = CGPointMake(width, 0)
        
        currentPage = 0
        prePage = -1
        nextPage = 1
        
        _tableView1.estimatedRowHeight = 100
        _tableView2.estimatedRowHeight = 100
        _tableView3.estimatedRowHeight = 100
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            return  4
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        self.initReusedPage(tableView)
        print(single.count)
        let question = single[reusedPage]

//        let record = userAnser[reusedPage]
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            cell?.selectionStyle = UITableViewCellSelectionStyle.Default
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.font = UIFont.systemFontOfSize(22)
        }
        if indexPath.section == 1 {
            
            for temp in userAns{
                let abcd = self.indexToABCD(indexPath.row)
                if temp.qid == question.id && temp.userAnswer == abcd{
                    if temp.userAnswer == question.answer{
                        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
                        cell?.textLabel?.textColor = UIColor.greenColor()
                        cell?.tintColor = UIColor.greenColor()
                    }
                    else{
                        cell?.accessoryType = UITableViewCellAccessoryType.None
                        cell?.textLabel?.textColor = UIColor.redColor()
                    }
                }
                else{
                    cell?.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            
            let abcd = self.indexToABCD(indexPath.row)
            for op in question.options!{
                let tempOption = op as! QuestionOption
                if tempOption.sort! == abcd{
                cell?.textLabel?.text = "\(tempOption.content!)"
                }
            }
           return cell!
        }
//        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark

        
        cell?.textLabel?.text = "\(reusedPage + 1)、\(question.title!)"
        cell?.textLabel?.numberOfLines = 0
//        cell?.setNeedsUpdateConstraints()
        cell?.updateConstraintsIfNeeded()
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let question = single[currentPage]
        
        for temp in userAns{
            if question.id == temp.qid{
                return
            }}
        
        let select = indexToABCD(indexPath.row)
                
        self.insertUserAnswer(question, userSelect: select)
                
        if select == question.answer {
            question.score = 10
                }
        else {
            question.score = 0
                }
                
        self.reloadAllTableViews()
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 200
        case 1:
            return 60
        default:
            return 100
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView == _scrollView) {
            
            let contentOffsetX = scrollView.contentOffset.x
            print(contentOffsetX)
            
            let width = scrollView.frame.size.width
            
            
            switch contentOffsetX {
            case 2 * width:
                
                ++currentPage
                ++prePage
                ++nextPage
                self.reloadAllTableViews()
                _scrollView.contentOffset = CGPointMake(width, 0)
                
            case 0:
                --currentPage
                --prePage
                --nextPage
                self.reloadAllTableViews()
                _scrollView.contentOffset = CGPointMake(width, 0)
                
            default:
                break
            }
        }
    }

    
    func insertUserAnswer(question:Question,userSelect:String) {
        
        
        let entity = NSEntityDescription.entityForName(EAUserQuestionRecord, inManagedObjectContext: coreDataStack.mainQueueContext)
        let userAnswerRec = UserQuestionRecord(entity: entity!, insertIntoManagedObjectContext: coreDataStack.mainQueueContext)
        
        for temp in userAns{
            
            if question.id == temp.qid{
                temp.userAnswer = userSelect
                
                return
            }
            else{

            }
        }
        userAnswerRec.addTime = NSDate()
        //        userAnswerRec.id = question.id
        userAnswerRec.qid = question.id
        userAnswerRec.userAnswer = userSelect
        print("userAnswerRec:\(userAnswerRec)")
        
        do{
            try coreDataStack.mainQueueContext.save()
            let count = userAns.count
            userAns.insert(userAnswerRec, atIndex: count)
        }catch let error as NSError{
            print("Could not save\(error),\(error.userInfo)")
        }
        

    }
    
    func fetchUserAnswer(question:Question){
        let fetchRequest = NSFetchRequest(entityName:EAUserQuestionRecord)
        fetchRequest.predicate = NSPredicate(format:"qid == %@", question.id!)
    
        do {
            let userAnwers = try coreDataStack.mainQueueContext.executeFetchRequest(fetchRequest)
            print("answers-----\(userAnwers.count)-----")
            
            for uAn in userAnwers {
                let temp = uAn as! UserQuestionRecord
                let count = userAns.count
                userAns.insert(temp, atIndex: count)
            }
        }catch{
            print(error)
        }
    }
    
    
    
    
    func reloadAllTableViews() {
        _tableView1.reloadData()
        _tableView2.reloadData()
        _tableView3.reloadData()
    }
    
    func parseInPaper() {
        //        setScoreLblValue(self.getScoreSum(questions))
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func indexToABCD(index:Int) ->String! {
        switch index {
        case 0:
            return "A"
        case 1:
            return "B"
        case 2:
            return "C"
        case 3:
            return "D"
        default:
            break
        }
        
        return nil
    }
    
    func getScoreSum(bookmark:[Question]) -> Int {
        
        let totalScore = 0
        return totalScore
    }
}