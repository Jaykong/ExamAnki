//
//  Card+CoreDataProperties.swift
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

extension Card {

    @NSManaged var end: String?
    @NSManaged var front: String?
    @NSManaged var id: String?
    @NSManaged var qid: String?
    @NSManaged var tag: NSNumber?
    @NSManaged var topic: FlashTopic?

}
