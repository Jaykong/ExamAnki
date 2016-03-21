//
//  EAPracticeToolbar.swift
//  ExamAnki
//
//  Created by ZhouLiang on 3/17/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPracticeToolbar: UIToolbar {
    
    private var toolbarItem = [UIBarButtonItem]()
    
    //上一页
    var preButtonItem:UIBarButtonItem{
        return UIBarButtonItem(image: UIImage(named: "Comment_Tab"), style: .Plain, target: self,action: "preAction:")
    }
    
    //下一页
    var nextButtonItem:UIBarButtonItem{
        return UIBarButtonItem(image: UIImage(named: "Comment_Tab"), style: .Plain, target: self,action: "nextAction:")
    }
    
    //查看答案
    var showAnswerButtonItem:UIBarButtonItem{
        return UIBarButtonItem(image: UIImage(named: "Comment_Tab"), style: .Plain, target: self,action: "showAnswerAction:")
    }
    
    //收藏题目
    var bookmarkButtonItem:UIBarButtonItem{
        return UIBarButtonItem(image: UIImage(named: "Comment_Tab"), style: .Plain, target: self,action: "bookmarkAction:")
    }
    
    //空白
    var flexibleSpaceBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    }
    
    func configureToolbar(){
        toolbarItem = [preButtonItem,showAnswerButtonItem,nextButtonItem]
        self.setItems(toolbarItem, animated: true)
    }
    
    func updateToolbar(){
        toolbarItem = [preButtonItem,bookmarkButtonItem,nextButtonItem]
        self.setItems(toolbarItem, animated: true)
    }
    

    
    //添加上一页事件
    func preAction(barButtonItem:UIBarButtonItem ){
        
    }
    //添加下一页事件
    func nextAction(barButtonItem:UIBarButtonItem ){
        
    }
    //添加展示答案事件
    func showAnswerAction(barButtonItem:UIBarButtonItem){
        updateToolbar()
    }
    //添加收藏事件
    func bookmarkAction(barButtonItem:UIBarButtonItem){
    
    }

}
