//
//  CoreDataStack.swift
//  ZTWWiki
//
//  Created by Wenslow on 16/1/17.
//  Copyright © 2016年 Wenslow. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
   static let sharedCoreDataStack = CoreDataStack()
   private init() {}
    
    //创建NSManagedObjectModel实例
    private lazy var mangedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("ExamAnki", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    private var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls.first!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.mangedObjectModel)
        let pathComponet = "ExamAnki.sqlite"
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(pathComponet)
        do {
          let store = try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            let manage = NSFileManager.defaultManager()
            try! manage.removeItemAtURL(url)
            
        }
        return coordinator
    }()
    
    //MARK: Context
    lazy var mainQueueContext: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = self.persistentStoreCoordinator
        moc.name = "Main Queue Cpntext (UI Context)"
        return moc
    }()
    
    //MARK: Save
    func saveContext () {
        if mainQueueContext.hasChanges {
            do {
                try mainQueueContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
               
                
                abort()
            }
        }
    }
}