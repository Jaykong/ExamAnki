//
//  EAPracticeViewController.swift
//  ExamAnki
//
//  Created by kongyunpeng on 3/23/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPracticeViewController: UIViewController {

    @IBOutlet weak var preTableView: EAQuestionTableView!
    @IBOutlet weak var currTableView: EAQuestionTableView!
    @IBOutlet weak var nextTableView: EAQuestionTableView!
    var quesitons:[Question]! = EAQuestionManager.getQuestions(NSUserDefaults.standardUserDefaults().stringForKey(EASelectedPaperID)!, typeCode:.choiceQuestion)
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        preTableView.registerCells(preTableView, question: quesitons[0])
        currTableView.registerCells(currTableView, question: quesitons[1])
         nextTableView.registerCells(nextTableView, question: quesitons[2])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
