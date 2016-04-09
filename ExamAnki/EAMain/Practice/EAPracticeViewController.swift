//
//  EAPracticeViewController.swift
//  ExamAnki
//
//  Created by kongyunpeng on 3/23/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPracticeViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var preTableView: EAQuestionTableView!
    @IBOutlet weak var currTableView: EAQuestionTableView!
    @IBOutlet weak var nextTableView: EAQuestionTableView!
    
    @IBOutlet weak var eascrollView: UIScrollView!
    var currPage = 0
    var quesitons:[Question]! = EAQuestionManager.getQuestions(NSUserDefaults.standardUserDefaults().stringForKey(EASelectedPaperID)!, typeCode:.choiceQuestion)
    
    func validatePage(page:Int) -> Int {
        var newPage = page
        if page == -1 {
            newPage = quesitons.count - 1
        }
        
        if page == quesitons.count {
            newPage = 0
        }
        return newPage
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        currTableView.registerCells(currTableView, question: quesitons[validatePage(currPage)])
        
        preTableView.registerCells(preTableView, question: quesitons[validatePage(currPage - 1)])
        
        nextTableView.registerCells(nextTableView, question: quesitons[validatePage(currPage + 1)])
    }

    func setQuestion() {
        currTableView.setQuestion(currTableView, question: quesitons[validatePage(currPage)])
        currPage = validatePage(currPage)
        
        preTableView.setQuestion(preTableView, question: quesitons[validatePage(currPage - 1)])
       
        nextTableView.setQuestion(nextTableView, question: quesitons[validatePage(currPage + 1)])
        let width = eascrollView.bounds.width
        self.eascrollView.contentOffset = CGPoint(x: width, y: 0)
    }
    
    override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
        let width = eascrollView.bounds.width
        self.eascrollView.contentOffset = CGPoint(x: width, y: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eascrollView.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let width = scrollView.bounds.width
            switch x {
            case 0:
                
                currPage -= 1
                setQuestion()
                
            case 2 * width:
                currPage += 1
                setQuestion()
                
            default:
                break
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
