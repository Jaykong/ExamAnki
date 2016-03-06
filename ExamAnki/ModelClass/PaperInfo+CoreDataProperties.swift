//
//  PaperInfo+CoreDataProperties.swift
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

extension PaperInfo {

    @NSManaged var addtime: NSDate?
    @NSManaged var answered: NSNumber?
    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var total: NSNumber?
    @NSManaged var type: String?

}
