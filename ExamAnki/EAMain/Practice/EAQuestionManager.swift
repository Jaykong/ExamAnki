//
//  EAQuestionManager.swift
//  ExamAnki
//
//  Created by kongyunpeng on 3/11/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAQuestionManager: EAQuestionManagerInterface {
    
   private class func getOneQuestion(qid:String) -> Question? {
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
    
    
   private class func getQuestionsWithTypeCode(typeCode:QuestionTypeCode) -> [Question]? {
        let request = NSFetchRequest(entityName: EAQuestion)
        let predicate = NSPredicate(format: "typecode==%i", typeCode.rawValue)
        let sortDescriptor = NSSortDescriptor(key: "sort", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        request.predicate = predicate
        do {
            let questions = try CoreDataStack.sharedCoreDataStack.mainQueueContext.executeFetchRequest(request)
            return questions as? [Question]
        } catch {
            print(error)
        }
        return nil
    }
    
    override class func getQuestions(paperid:String,typeCode:QuestionTypeCode) -> [Question]? {
       let questions = EAQuestionManager.getQuestionsWithTypeCode(typeCode)
      let results =  questions?.filter({ (ques) -> Bool in
           return ques.paperid == paperid
        })
        return results
        
       
    }
    
}