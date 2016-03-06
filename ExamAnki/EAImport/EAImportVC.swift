//
//  EAImport.swift
//  ExamAnki
//
//  Created by XinJinquan on 3/2/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit
import CoreData

class EAImportVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // testImportDB()
        fetchImportDB()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testImportDB(){
        XZPaperParsingService().parseHTML()
        CoreDataStack.sharedCoreDataStack.saveContext()
    }
    func fetchImportDB(){
        let fetch = NSFetchRequest(entityName:EAImportQuestion)
        do {
            let arr = try CoreDataStack.sharedCoreDataStack.mainQueueContext.executeFetchRequest(fetch)
            print("-----\(arr.count)-----")
            
            for ques in arr {
                let temp = ques as! ImportQuestion
                print("id        :\(temp.id)")
                print("headingid :\(temp.headingid)")
                print("typecode  :\(temp.typecode)")
                print("title     :\(temp.title)")
                print("sort      :\(temp.sort)")
                print("materialid:\(temp.materialid)")
                print("answer    :\(temp.answer)")
                print("score     :\(temp.score)")
                print("parse     :\(temp.parse)")
                print("---------------")
                
            }
        }catch{
            print(error)
        }
    }

}
