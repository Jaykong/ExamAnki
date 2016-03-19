//
//  EAPAbstractScrollview.swift
//  ExamAnki
//
//  Created by trainer on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPAbstractScrollview: UIScrollView {
    var contentView = UIView()
    class func createMainScrollView() -> EAPAbstractScrollview{
        return EAPScrollview()
    }
    
    func addTableViews() {
        fatalError()
    }
}
