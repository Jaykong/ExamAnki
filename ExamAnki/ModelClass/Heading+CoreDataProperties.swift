//
//  Heading+CoreDataProperties.swift
//  ExamAnki
//
//  Created by trainer on 2/26/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Heading {

    @NSManaged var id: String?
    @NSManaged var sort: NSNumber?
    @NSManaged var title: String?
    @NSManaged var type: String?
    @NSManaged var typecode: NSNumber?

}
