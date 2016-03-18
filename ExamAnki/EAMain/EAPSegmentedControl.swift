//
//  EAPSegmentedControl.swift
//  ExamAnki
//
//  Created by kongyunpeng on 3/17/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit
// MARK: - Protocol:
protocol EASegmentedControlDegate {
    func segmentValueDidChange(seg:EAPSegmentedControl)
}
class EAPSegmentedControl: EAPAbstractSegmentedControl {
    var delegate:EASegmentedControlDegate!
   convenience init() {
      let titles = EAPPaperManager.getTitlesFromPapers()
        
        self.init(items: titles)
        self.addTarget(self, action: "segmentedControlValueChanged:", forControlEvents: .ValueChanged)
    
    }
    
    func segmentedControlValueChanged (seg:EAPSegmentedControl) {
        
        
    }
    
}
