//
//  UserQuestionOption+CoreDataProperties.swift
//  ExamAnki
//
//  Created by kongyunpeng on 4/8/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserQuestionOption {

    @NSManaged var selected: NSNumber?
    @NSManaged var correct: NSNumber?
    @NSManaged var questionOption: QuestionOption?

}
