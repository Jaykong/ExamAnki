//
//  QuestionOption+CoreDataProperties.swift
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

extension QuestionOption {

    @NSManaged var content: String?
    @NSManaged var sort: String?
    @NSManaged var question: Question?
    @NSManaged var userQuestionOption: UserQuestionOption?

}
