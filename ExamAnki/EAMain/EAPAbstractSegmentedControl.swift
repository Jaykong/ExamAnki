//
//  EAPAbstractSegmentedControl.swift
//  ExamAnki
//
//  Created by kongyunpeng on 3/17/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPAbstractSegmentedControl: UISegmentedControl {
    class func createSegmentedControl() -> EAPAbstractSegmentedControl {
      let seg = EAPSegmentedControl()
        
      return seg
    }
}

