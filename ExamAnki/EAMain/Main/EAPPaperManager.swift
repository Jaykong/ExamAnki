//
//  EAPPaperManager.swift
//  ExamAnki
//
//  Created by kongyunpeng on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit
enum PaperCategoryName {
    case SimulatorPaper
    case PracticePaper
    case PreviousExamPaper
}

class EAPPaperManager: NSObject {
    class func getPaperNamesFromPapers(papers:[PaperInfo]) -> [String] {
       // let papers = EAPPaperManager.getPaperCategories()
        var titles:[String] = []
        for paper in papers {
            titles.append(paper.name!)
        }
        return titles
    }
    
   
    class func getOnePaperCategory(typename:String) -> [PaperInfo] {
        
        let fetchrequest = NSFetchRequest(entityName: EAPaperInfo)
       let predicate = NSPredicate(format: "type like %@", typename)
       fetchrequest.predicate = predicate
        let context = CoreDataStack.sharedCoreDataStack.mainQueueContext
        let papers = try! context.executeFetchRequest(fetchrequest) as! [PaperInfo]
        
        for paper in papers {
            print(paper.name,paper.type,paper.id)
        }
        return papers
    }
    
    class func getPaperCategories() -> [PaperInfo] {
        let fetchrequest = NSFetchRequest(entityName: EAPaperInfo)
        let context = CoreDataStack.sharedCoreDataStack.mainQueueContext
        let papers = try! context.executeFetchRequest(fetchrequest) as! [PaperInfo]
        
        for paper in papers {
            print(paper.name,paper.type,paper.id)
        }
        return papers
    }
    private static func returnPaperTypeFromArray(arr:[PaperInfo]) -> [String] {
        var titles:[String] = []
        for paper in arr {
            if !(titles.contains(paper.type!)) {
                titles.append(paper.type!)
            }
        }
        return titles
    }
    
    class func getTitlesFromPapers() -> [String] {
        
        let papers =  EAPPaperManager.getPaperCategories()
        let titles = EAPPaperManager.returnPaperTypeFromArray(papers)
        return titles
    }
    
    class func getTitlesFromPapers(paperType:String) -> [String] {
        
        let papers =  EAPPaperManager.getOnePaperCategory(paperType)
        let titles = EAPPaperManager.returnPaperTypeFromArray(papers)
        return titles
    }
    
}
//extension Array {
//  static func returnPaperTypeFromArray(arr:[PaperInfo]) -> [String] {
//    var titles:[String] = []
//    for paper in arr {
//        if !(titles.contains(paper.type!)) {
//       titles.append(paper.type!)
//        }
//    }
//    return titles
// }
//}
