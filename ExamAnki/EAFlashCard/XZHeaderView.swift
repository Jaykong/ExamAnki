//
//  XZHeaderView.swift
//  TableViewNodes
//
//  Created by zxz on 16/3/20.
//  Copyright © 2016年 zxz. All rights reserved.
//

import UIKit


class XZHeaderView: UITableViewHeaderFooterView {

    var indicatorImage: UIImageView!
    
    var textLable: UILabel!
    var section:Int!
    var isTapped:Bool = false {
        willSet{
            if newValue==true {
                UIView.animateWithDuration(0.5, delay: 0, options:.CurveEaseInOut, animations: { () -> Void in
                    self.indicatorImage.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI/2.0), 0, 0, 1)
                    }, completion: nil)
            }else{
                UIView.animateWithDuration(0.2, delay: 0, options:.CurveEaseInOut, animations: { () -> Void in
                    self.indicatorImage.layer.transform = CATransform3DMakeRotation(CGFloat(0), 0, 0, 1)
                    }, completion: nil)
            }
        }
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.indicatorImage = UIImageView(image: UIImage(named: "the_arrow.png"))
        self.indicatorImage.frame = CGRectMake(0, 0, 40, 40)
        self.indicatorImage.contentMode = .Center
        let frame = CGRectMake(40, 0, 300, 40)
        self.textLable = UILabel(frame: frame)
        self.contentView.addSubview(self.indicatorImage)
        self.contentView.addSubview(self.textLable)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    

}
