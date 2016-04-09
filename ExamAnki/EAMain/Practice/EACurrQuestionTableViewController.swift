//
//  EACurrQuestionTableViewController.swift
//  ExamAnki
//
//  Created by kongyunpeng on 4/6/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EACurrQuestionTableViewController: EAQuestionTableViewController {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       let newOptions = Question.sortedOptions(question)
  
        
        let selectedOption = newOptions[indexPath.row] as! QuestionOption
        
//        if question.answer == questionOptionNeedToStore.sort {
//            userOption.correct = NSNumber(bool: true)
//        } else {
//            userOption.correct = NSNumber(bool: false)
//        }
//        userOption.selected = NSNumber(bool: false)
        selectedOption.userQuestionOption?.selected = true
        
        
        tableView.reloadData()
    }
}
