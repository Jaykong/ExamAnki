//
//  EAPracticeViewController.swift
//  ExamAnki
//
//  Created by trainer on 3/14/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPracticeViewController: UIViewController,UIScrollViewDelegate {
    
    var eaQuestion = EAQuestionManager.getQuestionsWithTypeCode(QuestionTypeCode.choiceQuestion)!
    
    var eaScrollView:UIScrollView!
    var eaToolbar:UIToolbar!
    
    var prePage = 0
    var curPage = 0
    var nextPage = 0
    
    var eaQuestionTVC1 = EAQuestionTVC()
    var eaQuestionTVC2 = EAQuestionTVC()
    var eaQuestionTVC3 = EAQuestionTVC()
    
//    func addPaperidDidChangedNotification() {
//        NSNotificationCenter.defaultCenter().addObserverForName(PaperidDidChanged, object: nil
//            , queue: NSOperationQueue.mainQueue()) { (notfication) -> Void in
//                
//                let userInfo = notfication.userInfo as! [String:String]
//                let paperid = userInfo["paperid"]
//                print("the paperid is\(paperid)")
//        }
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       NSUserDefaults.standardUserDefaults().stringForKey(EASelectedPaperID)
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        eaScrollView = UIScrollView(frame: view.bounds)
        eaScrollView.pagingEnabled = true
        
        eaScrollView.contentSize = CGSizeMake(width * 3, height)
        
        eaQuestionTVC1.tableView!.frame = CGRectMake(0, 0, width, height)
        eaQuestionTVC2.tableView!.frame = CGRectMake(width, 0, width, height)
        eaQuestionTVC3.tableView!.frame = CGRectMake(2 * width ,0, width, height)
        
        
        eaScrollView.delegate = self
        
        eaScrollView.addSubview(eaQuestionTVC1.view)
        eaScrollView.addSubview(eaQuestionTVC2.view)
        eaScrollView.addSubview(eaQuestionTVC3.view)
        
        view.addSubview(eaScrollView)
        
        eaScrollView.bounces = false
        eaScrollView.alwaysBounceVertical = false
        
        self.edgesForExtendedLayout = UIRectEdge.Bottom
        
        eaScrollView.contentOffset = CGPointMake(width, 0)
        
        curPage = 0
        prePage = -1
        nextPage = 1
        
        self.reloadViews()
        
    }
    
    func reloadViews() {
        curPage = pageCheck(curPage)
        eaQuestionTVC2.question = eaQuestion[curPage]
        eaQuestionTVC2.tableView.reloadData()

        prePage = pageCheck(prePage)
        eaQuestionTVC1.question = eaQuestion[prePage]
        eaQuestionTVC1.tableView.reloadData()
        
        nextPage = pageCheck(nextPage)
        eaQuestionTVC3.question = eaQuestion[nextPage]
        eaQuestionTVC3.tableView.reloadData()
    }
    
    func pageCheck(page:Int) ->Int {
        if page == -1 {
            return eaQuestion.count - 1
        }
        if page >= eaQuestion.count {
            return 0
        }
        return page
    }

    func lastpage(){

    
    }
    
    func nextpage(){


    
    }
    
    func checkAnswer(){
        
    }

    func addToWrongLib(){
    
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView == eaScrollView) {
            
            let contentOffsetX = scrollView.contentOffset.x
            print(contentOffsetX)
            
            let width = scrollView.frame.size.width
            
            
            switch contentOffsetX {
            case 2 * width:
                
                ++curPage
                ++prePage
                ++nextPage
                self.reloadViews()
                eaScrollView.contentOffset = CGPointMake(width, 0)
                
            case 0:
                --curPage
                --prePage
                --nextPage
                self.reloadViews()
                eaScrollView.contentOffset = CGPointMake(width, 0)
                
            default:
                break
            }
        }
    }
    
    
}
