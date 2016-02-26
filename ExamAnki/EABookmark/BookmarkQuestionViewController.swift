//
//  BookmarkQuestionViewController.swift
//  ExamAnki
//
//  Created by ZhouLiang on 2/24/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class BookmarkQuestionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let bookType = ["单选题","多选题","判断题","综合题"]
    var single = 0,multiple = 0,alternative = 0,general = 0
    
    
    @IBOutlet weak var bookTableView: UITableView!
    
//    required init?(coder aDecoder: NSCoder) {
//        if(!self){
//            [self .superclass]
//        }
//    }
//    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        
//    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        self.view.addSubview(bookTableView)
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookType.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookmarkCell", forIndexPath: indexPath) as! BookmarkCell
        cell.bookStyleLabel.text = bookType[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
