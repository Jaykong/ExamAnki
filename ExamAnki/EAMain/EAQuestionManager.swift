//
//  EAQuestionManager.swift
//  ExamAnki
//
//  Created by kongyunpeng on 3/11/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAQuestionManager: NSObject {
    
    class func getOneQuestion(qid:String) -> Question? {
        let request = NSFetchRequest(entityName: EAQuestion)
        let predicate = NSPredicate(format: "id like %@", qid)
        request.predicate = predicate
        do {
            let questions = try CoreDataStack.sharedCoreDataStack.mainQueueContext.executeFetchRequest(request)
            if !questions.isEmpty {
                return questions[0] as? Question
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    class  func getQuestionsWithTypeCode(typeCode:QuestionTypeCode) -> [Question]? {
        let request = NSFetchRequest(entityName: EAQuestion)
        let predicate = NSPredicate(format: "typecode==%i", typeCode.rawValue)
        request.predicate = predicate
        do {
            let questions = try CoreDataStack.sharedCoreDataStack.mainQueueContext.executeFetchRequest(request)
            return questions as? [Question]
        } catch {
            print(error)
        }
        return nil
    }
}