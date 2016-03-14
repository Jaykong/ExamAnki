//
//  BookmarkCell.swift
//  ExamAnki
//
//  Created by ZhouLiang on 2/24/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class BookmarkCell: UITableViewCell {

    @IBOutlet weak var bookStyleLabel: UILabel!
    @IBOutlet weak var doAgain: UIButton!
    @IBOutlet weak var haveALook: UIButton!
    
    override func awakeFromNib() {
        
        doAgain.layer.borderColor = UIColor.blueColor().CGColor
        doAgain.layer.borderWidth = 2
        doAgain.layer.cornerRadius = 5
        
        haveALook.layer.borderColor = UIColor.blueColor().CGColor
        haveALook.layer.borderWidth = 2
        haveALook.layer.cornerRadius = 5
    }
}
