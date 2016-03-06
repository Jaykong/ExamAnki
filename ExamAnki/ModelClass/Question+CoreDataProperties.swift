//
//  Question+CoreDataProperties.swift
//  ExamAnki
//
//  Created by zxz on 16/3/6.
//  Copyright © 2016年 kongyunpeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Question {

    @NSManaged var answer: String?
    @NSManaged var hasimg: NSNumber?
    @NSManaged var headingid: String?
    @NSManaged var id: String?
    @NSManaged var materialid: String?
    @NSManaged var paperid: String?
    @NSManaged var papertype: String?
    @NSManaged var parse: String?
    @NSManaged var questionmate: String?
    @NSManaged var score: NSNumber?
    @NSManaged var sort: NSNumber?
    @NSManaged var title: String?
    @NSManaged var typecode: NSNumber?
    @NSManaged var options: NSSet?

}
