//
//  EAAnswer.swift
//  ExamAnki
//
//  Created by XinJinquan on 3/16/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAOptionCell: UITableViewCell {

    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var symbolBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    func updateCell(userOption:UserQuestionOption) {
        if userOption.correct!.boolValue {
            answerLbl.textColor = UIColor.greenColor()
           
        } else {
            answerLbl.textColor = UIColor.blackColor()
        }
        if userOption.selected!.boolValue {
           symbolBtn.setImage(UIImage(named: "SingleOptionCheckSelected"), forState: UIControlState.Normal)
        } else {
          symbolBtn.setImage(UIImage(named: "SingleOptionCheck"), forState: UIControlState.Normal)
        }
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
