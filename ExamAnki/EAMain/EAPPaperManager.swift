//
//  EAPPaperManager.swift
//  ExamAnki
//
//  Created by kongyunpeng on 3/18/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit

class EAPPaperManager: NSObject {
    
    class func getPaperCategories() -> [PaperInfo] {
        let fetchrequest = NSFetchRequest(entityName: EAPaperInfo)
        let context = CoreDataStack.sharedCoreDataStack.mainQueueContext
        let papers = try! context.executeFetchRequest(fetchrequest) as! [PaperInfo]
        
        for paper in papers {
            print(paper.name,paper.type,paper.id)
        }
        return papers
    }
}
