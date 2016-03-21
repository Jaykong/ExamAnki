//
//  EAPMainConstrainCreator.swift
//  ExamAnki
//
//  Created by kongyunpeng on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit



class EAPMainConstrainCreator: EAPaperConstrainDelegate {
    func addSegConstraints(controller: EAPaperInfoVC,scrollView:EAPAbstractScrollview,seg:EAPAbstractSegmentedControl) {
       

       // scrollView.backgroundColor = UIColor.redColor()
      //  scrollView.contentView.backgroundColor = UIColor ( red: 0.0, green: 0.5226, blue: 0.0, alpha: 1.0 )
        
        seg.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        // MARK:seg constraints
        constraints.append(NSLayoutConstraint(item: seg, attribute: .Top, relatedBy: .Equal, toItem: controller.topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: seg, attribute: .Bottom, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: seg, attribute: .Leading, relatedBy: .Equal, toItem: controller.view, attribute: .Leading, multiplier:1, constant: 0))
        constraints.append(NSLayoutConstraint(item: seg, attribute: .Trailing, relatedBy: .Equal, toItem: controller.view, attribute: .Trailing, multiplier:1, constant: 0))
        
        
        
        // MARK: scrollView constraints
        constraints.append(NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: seg, attribute: .Bottom, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: controller.bottomLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: scrollView, attribute: .Leading, relatedBy: .Equal, toItem: controller.view, attribute: .Leading, multiplier:1, constant: 0))
        constraints.append(NSLayoutConstraint(item: scrollView, attribute: .Trailing, relatedBy: .Equal, toItem: controller.view, attribute: .Trailing, multiplier:1, constant: 0))
        
        // MARK: contentView constraints
        constraints.append(NSLayoutConstraint(item: scrollView.contentView, attribute: .Top, relatedBy: .Equal, toItem: seg, attribute: .Bottom, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: scrollView.contentView, attribute: .Bottom, relatedBy: .Equal, toItem: controller.bottomLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: scrollView.contentView, attribute: .Leading, relatedBy: .Equal, toItem: scrollView, attribute: .Leading, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: scrollView.contentView, attribute: .Trailing, relatedBy: .Equal, toItem: scrollView, attribute: .Trailing, multiplier: 1, constant: 0))
        
        constraints.append(NSLayoutConstraint(item: scrollView.contentView, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 3, constant: 0))
        // constraints.append(NSLayoutConstraint(item: scrollView.contentView, attribute: .Height, relatedBy: .Equal, toItem: scrollView, attribute: .Height, multiplier:1, constant: 0))
        let tableviews = scrollView.contentView.subviews
        let tableview1 = tableviews[0] as! UITableView
        let tableview2 = tableviews[1] as! UITableView
        let tableview3 = tableviews[2] as! UITableView
        
        tableview1.delegate = controller
        tableview2.delegate = controller
        tableview3.delegate = controller
        
        tableview1.translatesAutoresizingMaskIntoConstraints = false
        tableview2.translatesAutoresizingMaskIntoConstraints = false
        tableview3.translatesAutoresizingMaskIntoConstraints = false
        
        tableview1.backgroundColor = UIColor.clearColor()
        
        constraints.append(NSLayoutConstraint(item: tableview1, attribute: .Width, relatedBy: .Equal, toItem: tableview2, attribute: .Width, multiplier:1, constant: 0))
        constraints.append(NSLayoutConstraint(item: tableview2, attribute: .Width, relatedBy: .Equal, toItem: tableview3, attribute: .Width, multiplier:1, constant: 0))
        
        //tableview1 vetical to contentview
        constraints.append(NSLayoutConstraint(item: tableview1, attribute: .Top, relatedBy: .Equal, toItem: seg, attribute: .Bottom, multiplier: 1, constant: 0))
        
        constraints.append(NSLayoutConstraint(item:tableview1 , attribute: .Bottom, relatedBy: .Equal, toItem: controller.bottomLayoutGuide, attribute: .Bottom, multiplier:1, constant: 0))
        
        //tableview 2, 3 vetical
        constraints.append(NSLayoutConstraint(item: tableview2, attribute: .Top, relatedBy: .Equal, toItem: seg, attribute: .Bottom, multiplier: 1, constant: 0))
        
        constraints.append(NSLayoutConstraint(item:tableview2 , attribute: .Bottom, relatedBy: .Equal, toItem: controller.bottomLayoutGuide, attribute: .Bottom, multiplier:1, constant: 0))
        
        constraints.append(NSLayoutConstraint(item: tableview3, attribute: .Top, relatedBy: .Equal, toItem: seg, attribute: .Bottom, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item:tableview3 , attribute: .Bottom, relatedBy: .Equal, toItem: controller.bottomLayoutGuide, attribute: .Bottom, multiplier:1, constant: 0))
        
        //tableview1 ,2 ,3 horizontal
        constraints.append(NSLayoutConstraint(item: tableview1, attribute: .Leading, relatedBy: .Equal, toItem: scrollView.contentView, attribute: .Leading, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: tableview1, attribute: .Trailing, relatedBy: .Equal, toItem: tableview2, attribute: .Leading, multiplier: 1, constant: 0))
        
        constraints.append(NSLayoutConstraint(item: tableview2, attribute: .Trailing, relatedBy: .Equal, toItem: tableview3, attribute: .Leading, multiplier:1, constant: 0))
        constraints.append(NSLayoutConstraint(item: tableview3, attribute: .Trailing, relatedBy: .Equal, toItem: scrollView.contentView, attribute: .Trailing, multiplier:1, constant: 0))
       
        
        controller.view.addConstraints(constraints)
        print("--------------------------\n\(scrollView.frame.height)")
        
        
    }
}
