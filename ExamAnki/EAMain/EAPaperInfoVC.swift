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
    func addSegConstraints(controller: EAPaperInfoVC,scrollView:EAPAbstractScrollview,seg:EAPAbstractSegmentedControl)
  
}

class EAPaperInfoVC: UIViewController,UIScrollViewDelegate {
    var seg:EAPAbstractSegmentedControl!
    var scrollView:EAPAbstractScrollview!
    var delegate:EAPaperConstrainDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
         seg = EAPAbstractSegmentedControl.createSegmentedControl()
         scrollView = EAPAbstractScrollview.createMainScrollView()
        seg.addTarget(self, action: "segmentValueDidChange:", forControlEvents: .ValueChanged)
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        self.view.addSubview(seg)
        
        self.delegate =  EAPMainConstrainCreator()
        delegate.addSegConstraints(self, scrollView: scrollView, seg: seg)
      
    }
   
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = Int(scrollView.contentOffset.x)
        if  offsetX == 2 * EAScreenWidth {
          seg.selectedSegmentIndex = 2
        }
        
        if  offsetX == 1 * EAScreenWidth {
            seg.selectedSegmentIndex = 1
        }
        
        if  offsetX == 0 * EAScreenWidth {
            seg.selectedSegmentIndex = 0
        }
        
    }
    
    func segmentValueDidChange(seg:EAPAbstractSegmentedControl) {
        switch seg.selectedSegmentIndex {
        case 0 :
            scrollView.setContentOffset(CGPoint(x: EAScreenWidth * 0, y: 0), animated: true)
        case 1 :
            scrollView.setContentOffset(CGPoint(x: EAScreenWidth * 1, y: 0), animated: true)
        case 2 :
            scrollView.setContentOffset(CGPoint(x: EAScreenWidth * 2, y: 0), animated: true)
        default :
            scrollView.setContentOffset(CGPoint(x: EAScreenWidth * 0, y: 0), animated: true)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
}
