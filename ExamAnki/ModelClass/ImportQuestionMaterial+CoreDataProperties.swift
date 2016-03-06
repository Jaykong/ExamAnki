//
//  ImportQuestionMaterial+CoreDataProperties.swift
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

extension ImportQuestionMaterial {

    @NSManaged var content: String?
    @NSManaged var headingid: String?
    @NSManaged var id: String?
    @NSManaged var qid: String?
    @NSManaged var sort: NSNumber?
    @NSManaged var title: String?
    @NSManaged var typecode: NSNumber?

}
