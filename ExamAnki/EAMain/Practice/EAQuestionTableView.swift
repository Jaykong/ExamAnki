//
//  EAQuestionTableView.swift
//  ExamAnki
//
//  Created by kongyunpeng on 4/6/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAQuestionTableView: UITableView {
    @IBOutlet weak var questonTableViewController:EAQuestionTableViewController!
    
    func registerCells(tableView:EAQuestionTableView,question:Question) {
        questonTableViewController.registerCells(self, question: question)
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
