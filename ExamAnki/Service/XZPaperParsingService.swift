//
//  XZPaperParsingService.swift
//  ExamAnki
//
//  Created by zxz on 16/3/3.
//  Copyright © 2016年 kongyunpeng. All rights reserved.
//

import UIKit

enum QuestionType:String {
    case choiceQuestion = "ChoiceQuestion"
    case multipleChoiceQuestion = "MultipleChoiceQuestion"
    case trueOrFalseQuestion = "TrueOrFalseQuestion"
    case materialQuestion = "MaterialQuestion"
}

enum QuestionTypeCode:Int {
    case choiceQuestion = 11
    case multipleChoiceQuestion = 12
    case trueOrFalseQuestion = 21
    case materialQuestion = 31
}

enum HeadingTypeCode:Int {
    case choiceOrMultipleQuestion = 10
    case trueOrFalseQuestion = 20
    case materialQuestion = 30
}

enum MaterialTypeCode:Int {
    case material = 41
}

class XZPaperParsingService: NSObject {
    //正则表达式
    enum QuestionTypeRegex:String {
        case choiceQuestion = "^[一,二,三,四,五,六,七,八,九,十].*单项选择题"
        case multipleChoiceQuestion = "^[一,二,三,四,五,六,七,八,九,十].*多项选择题"
        case trueOrFalseQuestion = "^[一,二,三,四,五,六,七,八,九,十].*判断题"
        case materialQuestion = "^[一,二,三,四,五,六,七,八,九,十].*分析题"
    }
    
    //解析文件的地址
    var paperURL:NSURL!
    
    func parseHTML(url:NSURL,title:String){
        var tempUrlComp = url.pathComponents
        tempUrlComp?.removeLast()
        paperURL = NSURL.fileURLWithPathComponents(tempUrlComp!)
        let data = NSData(contentsOfURL: url)
        if data == nil {
            return
        }
        let parse = TFHpple(data: data!, encoding: "UTF-8", isXML: false)
        var arr = parse.searchWithXPathQuery("//p") as! [TFHppleElement]
        let paper = XZModelService.sharedModelService.creatManagedObjectInTable(EAImportPaperInfo) as! ImportPaperInfo
        paper.id = creatID(0)
        paper.name = title
        while arr.count > 0 {
            let temp = arr.first!
            let ele = temp.content.stringByReplacingOccurrencesOfString(" ", withString: "")
            //取出单项选择题
            if matchQuestionType(ele, typeRegex: .choiceQuestion) {
                print(ele)
                let heading = XZModelService.sharedModelService.creatManagedObjectInTable(EAImportHeading) as! ImportHeading
                heading.id = creatID(HeadingTypeCode.choiceOrMultipleQuestion.rawValue)
                heading.title = ele
                heading.type = QuestionType.choiceQuestion.rawValue
                heading.paperid = paper.id
                heading.typecode = HeadingTypeCode.choiceOrMultipleQuestion.rawValue
                arr.removeFirst()
                
                let tempChoiceArr = selectQuestions(&arr,
                    endMatchRegexs: [
                        QuestionTypeRegex.trueOrFalseQuestion.rawValue,
                        QuestionTypeRegex.multipleChoiceQuestion.rawValue,
                        QuestionTypeRegex.materialQuestion.rawValue
                    ])
                chooseQuestion(inQuestions: tempChoiceArr, withHeading: heading)
                //多选
            }else if matchQuestionType(ele, typeRegex: .multipleChoiceQuestion){
                print(ele)
                let heading = XZModelService.sharedModelService.creatManagedObjectInTable(EAImportHeading) as! ImportHeading
                heading.id = creatID(HeadingTypeCode.choiceOrMultipleQuestion.rawValue)
                heading.title = ele
                heading.type = QuestionType.multipleChoiceQuestion.rawValue
                heading.paperid = paper.id
                heading.typecode = HeadingTypeCode.choiceOrMultipleQuestion.rawValue
                arr.removeFirst()
                
                let tempMulti = selectQuestions(&arr,
                    endMatchRegexs:[
                        QuestionTypeRegex.choiceQuestion.rawValue,
                        QuestionTypeRegex.trueOrFalseQuestion.rawValue,
                        QuestionTypeRegex.materialQuestion.rawValue
                    ])
                chooseQuestion(inQuestions: tempMulti, withHeading: heading)
                //判断
            }else if matchQuestionType(ele, typeRegex: .trueOrFalseQuestion) {
                print(ele)
                let heading = XZModelService.sharedModelService.creatManagedObjectInTable(EAImportHeading) as! ImportHeading
                heading.id = creatID(HeadingTypeCode.trueOrFalseQuestion.rawValue)
                heading.title = ele
                heading.type = QuestionType.trueOrFalseQuestion.rawValue
                heading.paperid = paper.id
                heading.typecode = HeadingTypeCode.trueOrFalseQuestion.rawValue
                arr.removeFirst()
                
                let tempTF = selectQuestions(&arr,
                    endMatchRegexs: [
                        QuestionTypeRegex.choiceQuestion.rawValue,
                        QuestionTypeRegex.materialQuestion.rawValue,
                        QuestionTypeRegex.multipleChoiceQuestion.rawValue])
                chooseQuestion(inQuestions: tempTF, withHeading: heading)
                //分析题
            }else if matchQuestionType(ele, typeRegex: .materialQuestion) {
                print(ele)
                let heading = XZModelService.sharedModelService.creatManagedObjectInTable(EAImportHeading) as! ImportHeading
                heading.id = creatID(HeadingTypeCode.materialQuestion.rawValue)
                heading.title = ele
                heading.type = QuestionType.materialQuestion.rawValue
                heading.paperid = paper.id
                heading.typecode = HeadingTypeCode.materialQuestion.rawValue
                arr.removeFirst()
                let tempMaterial = selectQuestions(&arr,
                    endMatchRegexs: [
                        QuestionTypeRegex.choiceQuestion.rawValue,
                        QuestionTypeRegex.trueOrFalseQuestion.rawValue,
                        QuestionTypeRegex.multipleChoiceQuestion.rawValue])
                chooseMaterialQuestion(inQuestions: tempMaterial, withHeading: heading)
                //所有都不匹配，删除
            }else{
                print("arr.first---\(arr.first?.content)")
                arr.removeFirst()
            }
        }
        
    }
    /**
     *  匹配题型
     *
     */
    func matchQuestionType(text:String ,typeRegex:QuestionTypeRegex) -> Bool{
        switch typeRegex {
        case .choiceQuestion:
            return match(text, regexs: [QuestionTypeRegex.choiceQuestion.rawValue])
        case .multipleChoiceQuestion:
            return match(text, regexs: [QuestionTypeRegex.multipleChoiceQuestion.rawValue])
        case .trueOrFalseQuestion:
            return match(text, regexs: [QuestionTypeRegex.trueOrFalseQuestion.rawValue])
        case .materialQuestion:
            return match(text, regexs: [QuestionTypeRegex.materialQuestion.rawValue])
        }
    }

    /**
     * 选出分析题，分析题已材料为主，没材料，则没有分析题，即使有问题和答案，也不保存
     *
    */
    func chooseMaterialQuestion(inQuestions questions:[TFHppleElement],withHeading:ImportHeading){
        var aQuestion:ImportQuestion?
        var aQuestionMaterial:ImportQuestionMaterial?
        
        for quesEle in questions {
            
            let img = quesEle.searchWithXPathQuery("//img")
            let ele = quesEle.content
            if ele != "" || img.count>0 {

                //有材料开头，开始创建‘ImportQuestionMaterial’
                if match(ele, regexs: ["^[0-9]"]) {
                    if aQuestionMaterial != nil && (aQuestionMaterial?.qid != "")&&(aQuestionMaterial?.title != "" || aQuestionMaterial?.content != "") { //到下一道分析题时，才保存
                        CoreDataStack.sharedCoreDataStack.saveContext()
                        aQuestionMaterial = nil
                        aQuestion = nil
                    }
                    print("材料文字内容---\(ele)")
                    aQuestionMaterial = XZModelService.sharedModelService.creatManagedObjectInTable(EAImportQuestionMaterial) as? ImportQuestionMaterial
                    aQuestionMaterial?.id = creatID(MaterialTypeCode.material.rawValue)
                    aQuestionMaterial?.title = ele
                    aQuestionMaterial?.headingid = withHeading.id
                    aQuestionMaterial?.typecode = MaterialTypeCode.material.rawValue
                    aQuestionMaterial?.sort = firstNumber(ele)
                //是否有图片，决定了matrial的content属性，此处只将最后一张图片保存
                }else if img.count > 0 {

                    let imgTF = img[0] as! TFHppleElement
                    let imgSrc = imgTF.objectForKey("src")
                    let imgPath = (paperURL.path)!+"/"+"\(imgSrc)"
                    print("材料图片\(imgPath)")
                    aQuestionMaterial?.content = imageBase64String(imgPath)
//                    print("\(aQuestionMaterial?.content)")
                //创建‘ImportQuestion’
                }else if match(ele, regexs: ["^([0-9])"]) || match(ele, regexs: ["^（[0-9]）"]) {
                    print("问题文字内容---\(ele)")
                    aQuestion = XZModelService.sharedModelService.creatManagedObjectInTable(EAImportQuestion) as? ImportQuestion
                    aQuestion?.title = ele
                    aQuestion?.id = creatID(QuestionTypeCode.materialQuestion.rawValue)
                    aQuestion?.paperid = withHeading.paperid
                    aQuestion?.headingid = withHeading.id
                    aQuestion?.typecode = typecodeWithHeadingType(withHeading)
                    aQuestion?.sort = firstNumber(ele)
                    //材料,hasimg属性这里不需要
                    aQuestionMaterial?.qid = aQuestion?.id
                    aQuestion?.materialid = aQuestionMaterial?.id
                }else if match(ele, regexs:["^答案"]) {
                    aQuestion?.answer = ele
                    print("材料题答案---\(ele)")
                }else if match(ele, regexs: ["^简析"]) {
                    print("材料题简析---\(ele)")
                    aQuestion?.parse = ele
                }else if match(ele, regexs: ["^分数"]){
                    print("材料题分数---\(ele)")
                    aQuestion?.score = firstNumber(ele)
                }
                
            }
        }
        //循环结束，将最后一个保存
        if aQuestionMaterial != nil { //到下一道分析题时，才保存
            CoreDataStack.sharedCoreDataStack.saveContext()
            aQuestionMaterial = nil
            aQuestion = nil
        }
    }
    /**
     *  选出问题并存入数据库(单选,多选,判断都是一个方法)
     * 
    */
    func chooseQuestion(inQuestions questions:[TFHppleElement],withHeading:ImportHeading ){
        var aQuestion:ImportQuestion?
        var aQuestionMaterial:ImportQuestionMaterial?
        var aQuestionOptions:Array<ImportQuestionOption>?
        
        for quesEle in questions {
            let ele = quesEle.content
            let img = quesEle.searchWithXPathQuery("//img")
            if ele != "" || img.count>0{
                // 匹配问题，
                if match(ele, regexs: ["^[0-9]"]) {
                    print("问题---\(ele)")
                    //只有遇到下一个问题时才将question保存
                    if aQuestion != nil && aQuestion?.title != nil && aQuestionOptions != nil{
                        aQuestion?.materialid = aQuestionMaterial?.id //此处只对应最后读的图片
                        aQuestion?.options = NSSet(array: aQuestionOptions!)
                        CoreDataStack.sharedCoreDataStack.saveContext()
                        aQuestion = nil
                        aQuestionOptions = nil
                        aQuestionMaterial = nil
                    }
                    //初始化‘Question’
                    aQuestion = XZModelService.sharedModelService.creatManagedObjectInTable(EAImportQuestion) as? ImportQuestion
                    aQuestion?.title = ele
                    aQuestion?.headingid = withHeading.id
                    aQuestion?.paperid = withHeading.paperid
                    aQuestion?.typecode = typecodeWithHeadingType(withHeading)
                    // id 没有细分
                    aQuestion?.id = creatID(typecodeWithHeadingType(withHeading))
                    aQuestion?.sort = firstNumber(ele)
                    
                    aQuestionOptions = [ImportQuestionOption]()
                    //在此处创建‘QuestionMaterial’，确保一个问题只一张图片，并且可确保不存入无效的图片
                    aQuestionMaterial = XZModelService.sharedModelService.creatManagedObjectInTable(EAImportQuestionMaterial) as? ImportQuestionMaterial
                    
                }else if img.count > 0 { //看是否有图片，如果有图片

                    let imgTF = img[0] as! TFHppleElement
                    let imgSrc = imgTF.objectForKey("src")
                    let imgPath = (paperURL.path)!+"/"+"\(imgSrc)"
                    print("材料图片\(imgPath)")
                    aQuestion?.hasimg = true
                    //图片‘content’
                    
                    aQuestionMaterial?.content = imageBase64String(imgPath)
                    aQuestionMaterial?.id = creatID(MaterialTypeCode.material.rawValue)
                    aQuestionMaterial?.headingid = withHeading.id
                    aQuestionMaterial?.typecode = MaterialTypeCode.material.rawValue
                    aQuestionMaterial?.qid = aQuestion!.id
                }else if match(ele, regexs:["^答案"]) {
                    print("答案---\(ele)")
                    aQuestion?.answer = ele
                }else if match(ele, regexs: ["^简析"]) {
                    print("简析---\(ele)")
                    aQuestion?.parse = ele
                }else if match(ele, regexs: ["^分数"]) {
                    print("分数---\(ele)")
                    aQuestion?.score = firstNumber(ele)
                    // 在一个问题创建后可无限制的存入选项，所以必须保证是有效选项！
                }else if match(ele, regexs: ["^[A-Z]"]){
                    if aQuestion != nil {
                        print("选项---\(ele)")
                        let aOpt = XZModelService.sharedModelService.creatManagedObjectInTable(EAImportQuestionOption) as? ImportQuestionOption
                        aOpt!.question = aQuestion
                        aOpt!.content = ele
                        aOpt!.sort = "\(ele.characters.first)"
                        aQuestionOptions?.append(aOpt!)
                    }
                }
                
            }
        }
        
        //存入最后一个有效‘Question’
        if aQuestion != nil && aQuestion?.title != nil && aQuestionOptions != nil{
            aQuestion?.materialid = aQuestionMaterial?.id
            aQuestion?.options = NSSet(array: aQuestionOptions!)
            CoreDataStack.sharedCoreDataStack.saveContext()

        }
    }
    /**
     * 根据终止的正则表达式数组,取出匹配的所有问题
     *
     */
    func selectQuestions(inout arr:[TFHppleElement], endMatchRegexs:[String]) -> [TFHppleElement]{
        var tempArr = [TFHppleElement]()
        while arr.count>0{
            let temp = arr.first!
            let ele = temp.content.stringByReplacingOccurrencesOfString(" ", withString: "")
            if (match(ele, regexs: endMatchRegexs)) {
                break
            }else{
                tempArr.append(temp)
                arr.removeFirst()
            }
        }
        return tempArr
    }
    
    /**
     *  字符串是否匹配一个正则表达式的数组
     *
     */
    func match(text:String,regexs:[String]) -> Bool {
        for reg in regexs {
            let regex = try! NSRegularExpression(pattern: reg, options: .AnchorsMatchLines)
            let match = regex.rangeOfFirstMatchInString(text, options: .ReportProgress, range:NSMakeRange(0, text.characters.count))
            if match.location != NSNotFound {
                return true
            }
        }
        return false
    }
    
    func firstNumber(aString:String) -> Int?{
        let regExp = try! NSRegularExpression(pattern: "[0-9]+", options:.AnchorsMatchLines)
        let range = regExp.firstMatchInString(aString, options: .ReportCompletion, range: NSMakeRange(0, aString.characters.count))?.range
        if range?.location != NSNotFound {
            let intNum = (aString as NSString).substringWithRange(range!)
            return Int(intNum)
        }else{
            return nil
        }
    }
    
    func typecodeWithHeadingType(heading:ImportHeading) -> Int {
        let type = QuestionType(rawValue: heading.type!)!
        switch type {
        case .choiceQuestion:
            return 11;
        case .multipleChoiceQuestion:
            return 12;
        case .trueOrFalseQuestion:
            return 21;
        case .materialQuestion:
            return 31;
        }
    }


    
}
