//
//  WrongQuestionVCCell.swift
//  ExamAnki
//
//  Created by XinJinquan on 2016/2/28.
//  Copyright © 2016年 kongyunpeng. All rights reserved.
//

import UIKit

class EAWrongQuestionVCCell: UITableViewCell {

    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var reviewBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
