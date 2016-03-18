//
//  EAPScrollview.swift
//  ExamAnki
//
//  Created by trainer on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPScrollview: EAPAbstractScrollview {
    var tableViews = [EAPMainTableView]()
    override init() {
        super.init()
        self.tableViews
    }
}
