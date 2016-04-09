//
//  Question.swift
//  ExamAnki
//
//  Created by zxz on 16/3/6.
//  Copyright © 2016年 kongyunpeng. All rights reserved.
//

import Foundation
import CoreData


class Question: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
  class  func sortedOptions(question:Question) -> NSArray{
        let sets = question.options!
        let options = Array (sets) as NSArray
        //  options.sortedArrayUsingSelector("caseInsensitiveCompare:")
        let sortDes = NSSortDescriptor(key: "sort", ascending: true)
        let newOptions = options.sortedArrayUsingDescriptors([sortDes])
        return newOptions
    }
}
