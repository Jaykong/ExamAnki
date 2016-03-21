//
//  EAPSegmentedControl.swift
//  ExamAnki
//
//  Created by kongyunpeng on 3/17/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPSegmentedControl: EAPAbstractSegmentedControl {
   
   convenience init() {
      let titles = EAPPaperManager.getTitlesFromPapers()
        
        self.init(items: titles)
    
    
    }
}
