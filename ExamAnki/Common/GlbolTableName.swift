//
//  GlbolTableName.swift
//  ExamAnki
//
//  Created by trainer on 2/26/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//
import UIKit

let EADataBaseName = "ExamAnki"

let EABookmarkRecord = "BookmarkRecord"
let EAFlashCard = "FlashCard"
let EAUserWrongQuestionRecord = "UserWrongQuestionRecord"
let EAUserQuestionRecord = "UserQuestionRecord"
let EAQuestionOption = "QuestionOption"
let EAQuestionMaterial = "QuestionMaterial"
let EAQuestion = "Question"
let EAPaperInfo = "PaperInfo"
let EAHeading = "Heading"
let EAFlashTopic = "FlashTopic"

let EAImportPaperInfo = "ImportPaperInfo"
let EAImportHeading = "ImportHeading"
let EAImportQuestionMaterial = "ImportQuestionMaterial"
let EAImportQuestion = "ImportQuestion"
let EAImportQuestionOption = "ImportQuestionOption"

/**
 * typecode)"+"+dateString+"+"+uuid
 *
 */
func creatID(typecode:Int) -> String {
    let uuid = NSUUID().UUIDString
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyMMddss"
    let dateString = dateFormatter.stringFromDate(NSDate())
    return "\(typecode)+"+dateString+"+"+uuid //41+16030350+A8B6B22C-DC01-4340-AFA1-594CC5765E8B
}

func imageBase64String(imgpath:String) -> String? {
    let baseData = NSData(contentsOfFile: imgpath)
    let baseStr = baseData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
    return baseStr
}

extension UIImage {
    convenience init?(base64String:String) {
        let imgData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))
        self.init(data: imgData!)
    }
}
















