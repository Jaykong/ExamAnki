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
    func setQuestion(tableView:EAQuestionTableView,question:Question) {
       questonTableViewController.setQuestion(question, tableView: self)
    }

}
