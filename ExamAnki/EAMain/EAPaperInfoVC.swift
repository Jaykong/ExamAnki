//
//  EAPaperInfoVC.swift
//  ExamAnki
//
//  Created by XinJinquan on 3/2/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit
// MARK: - Protocol: Add SegmentedControl Constraints
protocol EAPaperConstrainDelegate {
    func addSegConstraints(controller:UIViewController)
 
}

class EAPaperInfoVC: UIViewController,EASegmentedControlDegate {
    
    var delegate:EAPaperConstrainDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EAPPaperManager.getPaperCategories()
        
        self.delegate =  EAPMainConstrainCreator()
        delegate.addSegConstraints(self)
        
        
        
        
    }
    func segmentValueDidChange(seg: EAPSegmentedControl) {
        
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
