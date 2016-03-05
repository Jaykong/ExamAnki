//
//  TestPaperDataStore.swift
//  ExamAnki
//
//  Created by Wenslow on 16/2/23.
//  Copyright © 2016年 kongyunpeng. All rights reserved.
//

import UIKit
import CoreData
class XMLAnalysis: NSObject {

    let coreDataStack = CoreDataStack.sharedCoreDataStack
    let fetchRequest = NSFetchRequest()
    
    //MARK:解析XML文件并保存
    func fetchXMLData(fileName file: String) {
        
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "xml")
        
        let xmlData = NSData(contentsOfFile: path!)
        
        do {
            
            let xmlDoc = try AEXMLDocument(xmlData: xmlData!)
            
            //创建paperInfo
            creatTestPaper(xmlDoc)
           
            //创建试卷的题型
            creatHeadings(xmlDoc)
            
            //创建题目
            creatQuestions(xmlDoc)

        }catch {
            print(error)
        } 
    }
    //MARK: 创建试卷
    private func creatTestPaper(xmlDoc: AEXMLDocument){
        
        let paperInfo = NSEntityDescription.insertNewObjectForEntityForName(EAPaperInfo, inManagedObjectContext: coreDataStack.mainQueueContext) as! PaperInfo
        
        let name = xmlDoc["service"].attributes["title"]!
        let id = xmlDoc["service"].attributes["id"]!
        let type = xmlDoc["service"].attributes["type"]!
        let total = xmlDoc.root["question"].all?.count//试题总数
        let addTime = NSDate()
        let answered = 0
        
        paperInfo.name = name
        paperInfo.id = id
        paperInfo.type = type
        paperInfo.total = total
        paperInfo.addtime = addTime
        paperInfo.answered = answered
        
        coreDataStack.saveContext()
        
    }

    //MARK: 创建heading
    private func creatHeadings(xmlDoc: AEXMLDocument){
        
        let headings = xmlDoc.root["heading"].all
        
        for heading in headings! {
            
            let headingNeedToStore = NSEntityDescription.insertNewObjectForEntityForName(EAHeading, inManagedObjectContext: coreDataStack.mainQueueContext) as! Heading
            
            let id = heading["id"].stringValue
            let sort = Int(heading["sort"].stringValue)!
            let typeCode = Int(heading["type"].stringValue)!
            let type = heading["abbr"].stringValue
            let title = heading["title"].stringValue
            
            headingNeedToStore.id = id
            headingNeedToStore.sort = sort
            headingNeedToStore.type = type
            headingNeedToStore.typecode = typeCode
            headingNeedToStore.title = title
            
            coreDataStack.saveContext()
        }
    }
    
    //MARK: 创建题目
    private func creatQuestions(xmlDoc: AEXMLDocument) {
        
        let questions = xmlDoc.root["question"].all
        
        for questionInXML in questions! {
            
            let questionNeedToStore = NSEntityDescription.insertNewObjectForEntityForName(EAQuestion, inManagedObjectContext: coreDataStack.mainQueueContext) as! Question
            
            
            let hasImage: Bool = {
                let num = Int(questionInXML.attributes["hasimg"]!)!
                switch num {
                case 0: return false
                default: return true
                }
            }()
            
            let title = questionInXML["title"].stringValue
            let sort = Int(questionInXML["sort"].stringValue)!
            let id = questionInXML["id"].stringValue
            let paperId = xmlDoc["service"].attributes["id"]!//试卷ID
            let type = Int(questionInXML["type"].stringValue)
            let paperType = xmlDoc["service"].attributes["type"]!//试卷类型
            let score = Int(questionInXML["score"].stringValue)!
            let answer = questionInXML["answer"].stringValue
            let parse = questionInXML["parse"].stringValue
            let headingId = questionInXML["headingid"].stringValue
            let materialId = questionInXML["materialid"].value
            
            questionNeedToStore.title = title
            questionNeedToStore.sort = sort
            questionNeedToStore.id = id
            questionNeedToStore.papertype = paperType
            questionNeedToStore.typecode = type
            questionNeedToStore.paperid = paperId
            questionNeedToStore.score = score
            questionNeedToStore.answer = answer
            questionNeedToStore.parse = parse
            questionNeedToStore.hasimg = hasImage
            questionNeedToStore.headingid = headingId
            questionNeedToStore.materialid = materialId
            
            //选择题选项
            if type == 11 || type == 12 {
                //将选项和选择题关联
                questionNeedToStore.options = creatOptionData(questionInXML, question: questionNeedToStore)
            }
            
            coreDataStack.saveContext()
        }
        
        //creat material
        creatMaterials(xmlDoc)
    }

    //MARK: 创建选择题选项
    private func creatOptionData(questionInXML: AEXMLElement, question: Question) -> NSSet {
        
        let options = questionInXML["options"].children
        
        var questionOptions = [QuestionOption]()
        
        for option in options {
            
            let questionOptionNeedToStore = NSEntityDescription.insertNewObjectForEntityForName(EAQuestionOption, inManagedObjectContext: coreDataStack.mainQueueContext) as! QuestionOption
            
            let sort = option.attributes["sort"]
            let content = option.stringValue
            
            questionOptionNeedToStore.sort = sort
            questionOptionNeedToStore.content = content
            questionOptionNeedToStore.question = question
            
            coreDataStack.saveContext()
            
            questionOptions.append(questionOptionNeedToStore)
        }
        
        return NSSet(array: questionOptions)
    }
    
    //MARK: 创建主观题素材
    private func creatMaterials(xmlDoc: AEXMLDocument){
        
        if let materials = xmlDoc.root["material"].all {
            
            for item in materials {
                
                let materialNeedToStore = NSEntityDescription.insertNewObjectForEntityForName(EAQuestionMaterial, inManagedObjectContext: coreDataStack.mainQueueContext) as! QuestionMaterial
                
                let id = item["id"].stringValue
                let headingId = item["headingid"].stringValue
                let sort = Int(item["sort"].stringValue)!
                let typecode = Int(item["type"].stringValue)!
                let content = item["content"].stringValue
                
                materialNeedToStore.id = id
                materialNeedToStore.headingid = headingId
                materialNeedToStore.sort = sort
                materialNeedToStore.typecode = typecode
                materialNeedToStore.content = content
                
                coreDataStack.saveContext()
                
            }
        }

    }
    
    
    //MARK: old method
//    //MARK:获取试卷数据
//    func getTestPaperData()-> [TestPaper]{
//        
//        var testPapers = [TestPaper]()
//        
//        let entityDescription = NSEntityDescription.entityForName("TestPaper", inManagedObjectContext: self.coreDataStack.mainQueueContext)
//        
//        fetchRequest.entity = entityDescription
//        
//        
//        do {
//            let results = try self.coreDataStack.mainQueueContext.executeFetchRequest(fetchRequest)
//            for result in results {
//                
//                let title = result.valueForKey("title") as! String
//                let id = result.valueForKey("id") as! String
//                let type = result.valueForKey("type") as! String
//                let numberOfQuestion = result.valueForKey("numberOfQuestion") as! Int
//                let numberOfQuestionWhichIsFinished = result.valueForKey("numberOfQuestionWhichIsFinished") as? Int
//                let numberOfQuestionWhichIsWrong = result.valueForKey("numberOfQuestionWhichIsWrong") as? Int
//                
//                let testPaper = TestPaper(testPaperTitle: title, id: id, type: type, numberOfQuestion: numberOfQuestion)
//                
//                testPaper.numberOfQuestionWhichIsFinished = numberOfQuestionWhichIsFinished!
//                testPaper.numberOfQuestionWhichIsWrong = numberOfQuestionWhichIsWrong!
//                
//                let headings = result.valueForKey("heading") as! NSSet
//                
//                testPaper.headings = getHeadingsData(headingsObject: headings)
//                
//                testPapers.append(testPaper)
//                
//            }
//        } catch {
//            print(error)
//        }
//        
//        return testPapers
//    }
//    
//    //MARK: 获取heading数据
//    private func getHeadingsData(headingsObject headings: NSSet) -> [Heading] {
//        
//        var testHeadings = [Heading]()
//        
//        for heading in headings {
//            
//            let id = heading.valueForKey("id") as! String
//            let sort = heading.valueForKey("sort") as! Int
//            let type = heading.valueForKey("type") as! Int
//            let abbr = heading.valueForKey("abbr") as! String
//            let title = heading.valueForKey("title") as! String
//            let headingData = Heading(headingId: id, sort: sort, type: type, abbr: abbr, title: title)
//            
//            switch headingData.sort{
//            case 1:
//                
//                let singleChoiceQuestions = heading.valueForKey("singleChoiceQuestion") as! NSSet
//                
//                headingData.singleChoiceQuestions = getChoiceQuestionData(choiceQuestionsObject: singleChoiceQuestions)
//                
//            case 2:
//                let multiChoiceQuestions = heading.valueForKey("multiChoiceQuestion") as! NSSet
//                
//                headingData.multiChoiceQuestions = getChoiceQuestionData(choiceQuestionsObject: multiChoiceQuestions)
//                
//            case 3:
//                let materialQuestions = heading.valueForKey("materialQuestion") as! NSSet
//                
//                headingData.materialQuestions = getMaterialQuestionData(materialQuestionsObject: materialQuestions)
//                
//            default: break
//            }
//            
//            
//            testHeadings.append(headingData)
//        }
//        
//        return testHeadings.sort { (heading1, heading2) -> Bool in
//            if heading1.sort < heading2.sort {
//                return true
//            } else {
//                return false
//            }
//        }
//    }
//    
//    //MARK: 获取选择题数据
//    private func getChoiceQuestionData(choiceQuestionsObject choiceQuestions: NSSet) -> [ChoiceQuestion]{
//        
//        var testChoiceQuestions = [ChoiceQuestion]()
//        
//        for choiceQuestion in choiceQuestions {
//            
//            let hasImg = choiceQuestion.valueForKey("hasImg") as! Bool
//            let id = choiceQuestion.valueForKey("id") as! String
//            let headingId = choiceQuestion.valueForKey("headingId") as! String
//            let sort = choiceQuestion.valueForKey("sort") as! Int
//            let type = choiceQuestion.valueForKey("type") as! Int
//            let score = choiceQuestion.valueForKey("score") as! Int
//            let answer = choiceQuestion.valueForKey("answer") as! String
//            let title = choiceQuestion.valueForKey("title") as! String
//            let parse = choiceQuestion.valueForKey("parse") as! String
//            let didWrongTime = choiceQuestion.valueForKey("didWrongTime") as? NSData
//            let savedTime = choiceQuestion.valueForKey("savedTime") as? NSData
//            let thisQuestionWasDone = choiceQuestion.valueForKey("thisQuestionWasDone") as! Bool
//            let thisQuestionWasSaved = choiceQuestion.valueForKey("thisQuestionWasSaved") as! Bool
//            let userDidWrong = choiceQuestion.valueForKey("userDidWrong") as! Bool
//            let choiceQuestionOptions = choiceQuestion.valueForKey("options") as! NSSet
//            
//            let choiceQuestion = ChoiceQuestion(whethesHasImage: hasImg, id: id, headingId: headingId, sort: sort, type: type, score: score, answer: answer, title: title, parse: parse)
//            
//            choiceQuestion.didWrongTime = didWrongTime
//            choiceQuestion.savedTime = savedTime
//            choiceQuestion.thisQuestionWasDone = thisQuestionWasDone
//            choiceQuestion.thisQuestionWasSaved = thisQuestionWasSaved
//            choiceQuestion.userDidWrong = userDidWrong
//            choiceQuestion.options = getChoiceQuestionOptionsData(choiceQuestionOptionsObject: choiceQuestionOptions)
//            
//            testChoiceQuestions.append(choiceQuestion)
//        }
//        
//        return testChoiceQuestions.sort({ (question1, question2) -> Bool in
//            if question1.sort < question2.sort {
//                return true
//            }else {
//                return false
//            }
//        })
//    }
//    
//    //MARK: 获取选择题选项
//    private func getChoiceQuestionOptionsData(choiceQuestionOptionsObject choiceQuestionOptions: NSSet) -> [ChoiceQuestionOption]{
//        
//        var options = [ChoiceQuestionOption]()
//        
//        for option in choiceQuestionOptions {
//            
//            let optionSort = option.valueForKey("optionSort") as! String
//            let optionContent = option.valueForKey("optionContent") as! String
//            
//            let option = ChoiceQuestionOption(optionOfChoice: optionSort, optionContent: optionContent)
//            options.append(option)
//        }
//        
//        return options.sort({ (option1, option2) -> Bool in
//            if option1.optionSort < option2.optionSort {
//                return true
//            }else {
//                return false
//            }
//        })
//    }
//    
//    //MARK: 获取主观题题目
//    private func getMaterialQuestionData(materialQuestionsObject materialQuestions: NSSet) -> [MaterialQuestion]{
//        
//        var testMaterialQuestions = [MaterialQuestion]()
//        
//        for materialQuestion in materialQuestions {
//            
//            let hasImg = materialQuestion.valueForKey("hasImg") as! Bool
//            let materialId = materialQuestion.valueForKey("materialId") as! String
//            let id = materialQuestion.valueForKey("id") as! String
//            let headingId = materialQuestion.valueForKey("headingId") as! String
//            let sort = materialQuestion.valueForKey("sort") as! Int
//            let type = materialQuestion.valueForKey("type") as! Int
//            let score = materialQuestion.valueForKey("score") as! Int
//            let answer = materialQuestion.valueForKey("answer") as! String
//            let title = materialQuestion.valueForKey("title") as! String
//            let didWrongTime = materialQuestion.valueForKey("didWrongTime") as? NSData
//            let savedTime = materialQuestion.valueForKey("savedTime") as? NSData
//            let thisQuestionWasDone = materialQuestion.valueForKey("thisQuestionWasDone") as! Bool
//            let thisQuestionWasSaved = materialQuestion.valueForKey("thisQuestionWasSaved") as! Bool
//            let userDidWrong = materialQuestion.valueForKey("userDidWrong") as! Bool
//            let material = materialQuestion.valueForKey("material") as! NSSet
//            
//            let materialQuestion = MaterialQuestion(whethesHasImage: hasImg, id: id, materialId: materialId, headingId: headingId, sort: sort, type: type, score: score, answer: answer, title: title)
//            
//            materialQuestion.didWrongTime = didWrongTime
//            materialQuestion.savedTime = savedTime
//            materialQuestion.thisQuestionWasDone = thisQuestionWasDone
//            materialQuestion.thisQuestionWasSaved = thisQuestionWasSaved
//            materialQuestion.userDidWrong = userDidWrong
//            materialQuestion.material = getMaterialData(materialObject: material)
//            
//            testMaterialQuestions.append(materialQuestion)
//        }
//        
//        return testMaterialQuestions.sort({ (question1, question2) -> Bool in
//            if question1.sort < question2.sort {
//                return true
//            }else {
//                return false
//            }
//        })
//    }
//    
//    //MARK: 获取主观题材料
//    private func getMaterialData(materialObject materialSet: NSSet) -> Material{
//        
//        let materialObject = materialSet.anyObject()!
//        
//        let id = materialObject.valueForKey("id") as! String
//        let headingId = materialObject.valueForKey("headingId") as! String
//        let sort = materialObject.valueForKey("sort") as! Int
//        let type = materialObject.valueForKey("type") as! Int
//        let content = materialObject.valueForKey("content") as! String
//        
//        let matetial = Material(materialId: id, headingId: headingId, sort: sort, type: type, content: content)
//        
//        return matetial
//    }
    

    
//
//    //MARK: 保存试卷
//    private func saveTestPaper(testPaper: TestPaper) {
//        
//        let entityDescription = NSEntityDescription.entityForName("TestPaper", inManagedObjectContext: self.coreDataStack.mainQueueContext)
//        fetchRequest.entity = entityDescription
//        let newTestPaper = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: self.coreDataStack.mainQueueContext)
//        
//        newTestPaper.setValue(testPaper.id, forKey: "id")
//        newTestPaper.setValue(testPaper.title, forKey: "title")
//        newTestPaper.setValue(testPaper.type, forKey: "type")
//        newTestPaper.setValue(testPaper.numberOfQuestion, forKey: "numberOfQuestion")
//        newTestPaper.setValue(testPaper.numberOfQuestionWhichIsFinished, forKey: "numberOfQuestionWhichIsFinished")
//        newTestPaper.setValue(testPaper.numberOfQuestionWhichIsWrong, forKey: "numberOfQuestionWhichIsFinished")
//        
//        //relationShip
//        newTestPaper.setValue(NSSet(), forKey: "heading")
//        
//        do {
//            try newTestPaper.managedObjectContext?.save()
//            try coreDataStack.mainQueueContext.save()
//            //print("save successful")
//        } catch {
//            print(error)
//        }
//        
//        saveHeadings(testPaper.headings, newTestPaperManagedObject: newTestPaper)
//    }
//    
//    //MARK: 保存headings
//    private func saveHeadings(headings: [Heading], newTestPaperManagedObject: NSManagedObject) {
//        
//        let entityDescription = NSEntityDescription.entityForName("Heading", inManagedObjectContext: self.coreDataStack.mainQueueContext)
//        
//        for heading in headings {
//            
//            let newHeading = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: self.coreDataStack.mainQueueContext)
//            
//            newHeading.setValue(heading.id, forKey: "id")
//            newHeading.setValue(heading.title, forKey: "title")
//            newHeading.setValue(heading.type, forKey: "type")
//            newHeading.setValue(heading.abbr, forKey: "abbr")
//            newHeading.setValue(heading.sort, forKey: "sort")
//            
//            switch heading.sort {
//            case 1:
//                //relationShip
//                newHeading.setValue(NSSet(), forKey: "singleChoiceQuestion")
//                saveChoiceQuestion(heading.singleChoiceQuestions, newHeadingManagedObject: newHeading, relationShipName: "singleChoiceQuestion")
//                
//            case 2:
//                //relationShip
//                newHeading.setValue(NSSet(), forKey: "multiChoiceQuestion")
//                saveChoiceQuestion(heading.multiChoiceQuestions, newHeadingManagedObject: newHeading, relationShipName: "multiChoiceQuestion")
//            case 3:
//                //relationShip
//                newHeading.setValue(NSSet(), forKey: "materialQuestion")
//                saveMaterialQuestion(heading.materialQuestions, newHeadingManagedObject: newHeading)
//            default: break
//            }
//            let headingData = newTestPaperManagedObject.mutableSetValueForKey("heading")
//            headingData.addObject(newHeading)
//            //print("add successful")
//        }
//    }
//    
//    //MARK: 保存选择题
//    private func saveChoiceQuestion(choiceQuestions: [ChoiceQuestion], newHeadingManagedObject: NSManagedObject, relationShipName: String) {
//        let entityDescription = NSEntityDescription.entityForName("ChoiceQuestion", inManagedObjectContext: self.coreDataStack.mainQueueContext)
//        
//        for choiceQuestion in choiceQuestions {
//            
//            let newChoiceQuestion = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: self.coreDataStack.mainQueueContext)
//            
//            newChoiceQuestion.setValue(choiceQuestion.hasImg, forKey: "hasImg")
//            newChoiceQuestion.setValue(choiceQuestion.thisQuestionWasDone, forKey: "thisQuestionWasDone")
//            newChoiceQuestion.setValue(choiceQuestion.thisQuestionWasSaved, forKey: "thisQuestionWasSaved")
//            newChoiceQuestion.setValue(choiceQuestion.userDidWrong, forKey: "userDidWrong")
//            newChoiceQuestion.setValue(choiceQuestion.answer, forKey: "answer")
//            newChoiceQuestion.setValue(choiceQuestion.headingId, forKey: "headingId")
//            newChoiceQuestion.setValue(choiceQuestion.id, forKey: "id")
//            newChoiceQuestion.setValue(choiceQuestion.parse, forKey: "parse")
//            newChoiceQuestion.setValue(choiceQuestion.title, forKey: "title")
//            newChoiceQuestion.setValue(choiceQuestion.score, forKey: "score")
//            newChoiceQuestion.setValue(choiceQuestion.sort, forKey: "sort")
//            newChoiceQuestion.setValue(choiceQuestion.type, forKey: "type")
//            
//            newChoiceQuestion.setValue(NSSet(), forKey: "options")
//            
//            saveChoiceQuestionOptions(choiceQuestion.options, newChoiceQuestion: newChoiceQuestion)
//            
//            let choiceQuestion = newHeadingManagedObject.mutableSetValueForKey(relationShipName)
//            choiceQuestion.addObject(newChoiceQuestion)
//            //print("success")
//        }
//    }
//    
//    //MARK: 保存选择题的选项
//    private func saveChoiceQuestionOptions(choiceQuestionOptions: [ChoiceQuestionOption], newChoiceQuestion: NSManagedObject) {
//        
//        let entityDescription = NSEntityDescription.entityForName("ChoiceQuestionOption", inManagedObjectContext: self.coreDataStack.mainQueueContext)
//            
//        for choiceQuestionOption in choiceQuestionOptions {
//            
//            let newChoiceQuestionOption = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: self.coreDataStack.mainQueueContext)
//            
//            newChoiceQuestionOption.setValue(choiceQuestionOption.optionSort, forKey: "optionSort")
//            newChoiceQuestionOption.setValue(choiceQuestionOption.optionContent, forKey: "optionContent")
//            
//            let choiceQuestionOption = newChoiceQuestion.mutableSetValueForKey("options")
//            choiceQuestionOption.addObject(newChoiceQuestionOption)
//            //print("add success")
//        }
//    }
//    
//    //MARK: 保存主观题
//    private func saveMaterialQuestion(materialQuestions: [MaterialQuestion], newHeadingManagedObject: NSManagedObject) {
//        
//        let entityDescription = NSEntityDescription.entityForName("MaterialQuestion", inManagedObjectContext: self.coreDataStack.mainQueueContext)
//        
//        for materialQuestion in materialQuestions {
//            
//            let newMaterialQuestion = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: self.coreDataStack.mainQueueContext)
//            
//            newMaterialQuestion.setValue(materialQuestion.hasImg, forKey: "hasImg")
//            newMaterialQuestion.setValue(materialQuestion.thisQuestionWasDone, forKey: "thisQuestionWasDone")
//            newMaterialQuestion.setValue(materialQuestion.thisQuestionWasSaved, forKey: "thisQuestionWasSaved")
//            newMaterialQuestion.setValue(materialQuestion.userDidWrong, forKey: "userDidWrong")
//            newMaterialQuestion.setValue(materialQuestion.answer, forKey: "answer")
//            newMaterialQuestion.setValue(materialQuestion.headingId, forKey: "headingId")
//            newMaterialQuestion.setValue(materialQuestion.id, forKey: "id")
//            newMaterialQuestion.setValue(materialQuestion.materialId, forKey: "materialId")
//            newMaterialQuestion.setValue(materialQuestion.title, forKey: "title")
//            newMaterialQuestion.setValue(materialQuestion.score, forKey: "score")
//            newMaterialQuestion.setValue(materialQuestion.sort, forKey: "sort")
//            newMaterialQuestion.setValue(materialQuestion.type, forKey: "type")
//            
//            
//            //print(materialQuestion.material?.content)
//            newMaterialQuestion.setValue(NSSet(), forKey: "material")
//            
//            saveMaterial(materialQuestion.material!, newMaterialQuestionManagedObject: newMaterialQuestion)
//            
//            let materialQuestion = newHeadingManagedObject.mutableSetValueForKey("materialQuestion")
//            materialQuestion.addObject(newMaterialQuestion)
//            
//        }
//    }
//    
//    //MARK: 保存主观题材料
//    private func saveMaterial(material: Material, newMaterialQuestionManagedObject: NSManagedObject) {
//        
//        let entityDescription = NSEntityDescription.entityForName("Material", inManagedObjectContext: self.coreDataStack.mainQueueContext)
//        
//        let newMaterial = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: self.coreDataStack.mainQueueContext)
//        
//        newMaterial.setValue(material.content, forKey: "content")
//        newMaterial.setValue(material.headingId, forKey: "headingId")
//        newMaterial.setValue(material.id, forKey: "id")
//        newMaterial.setValue(material.sort, forKey: "sort")
//        newMaterial.setValue(material.type, forKey: "type")
//            
//        let material = newMaterialQuestionManagedObject.mutableSetValueForKey("material")
//        material.addObject(newMaterial)
//            //print("add success")
//    }
}
