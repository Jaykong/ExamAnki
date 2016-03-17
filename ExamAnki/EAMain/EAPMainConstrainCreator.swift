//
//  EAPMainConstrainCreator.swift
//  ExamAnki
//
//  Created by kongyunpeng on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPMainConstrainCreator: EAPaperConstrainDelegate {
    func addSegConstraints(controller: UIViewController) {
        let seg = EAPAbstractSegmentedControl.createSegmentedControl(["a","b","c"])
        controller.view.addSubview(seg)
        let mapping = ["seg":seg]
        seg.translatesAutoresizingMaskIntoConstraints = false
        var constraints =  NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[seg]-0-|", options: [], metrics: nil, views: mapping)
        
        let constraint = seg.topAnchor.constraintEqualToAnchor(controller.topLayoutGuide.bottomAnchor, constant: 0)
        constraints.append(constraint)
        controller.view.addConstraints(constraints)
    }
}
