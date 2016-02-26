//
//  SharedModelService.swift
//  ExamAnki
//
//  Created by zxz on 16/2/23.
//  Copyright © 2016年 kongyunpeng. All rights reserved.
//

import Foundation
import CoreData

class XZModelService: NSObject {
    static let sharedModelService = XZModelService()
    lazy var context:NSManagedObjectContext = {
        return AppDelegate().managedObjectContext
    }()
    private override init() {}
    
    func creatManagedObjectInTable(tableName:String) -> NSManagedObject {
        return NSEntityDescription.insertNewObjectForEntityForName(tableName, inManagedObjectContext: context)
    }
    func removeManagedObject(obj:NSManagedObject) {
        self.context.deleteObject(obj )
        AppDelegate().saveContext()
    }
    func getAllManagedObjecsInTable(tableName:String) -> [AnyObject] {
        let fetchRequest = NSFetchRequest(entityName: tableName)
        do {
            let arr = try self.context.executeFetchRequest(fetchRequest)
            return arr
        }catch{
            print(error)
            abort()
        }
    }
}
