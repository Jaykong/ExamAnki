//
//  EAImport.swift
//  ExamAnki
//
//  Created by XinJinquan on 3/2/16.
//  Copyright © 2016 kongyunpeng. All rights reserved.
//

import UIKit
import CoreData

class EAImportVC: UIViewController,UITableViewDataSource,UITableViewDelegate{

    let fileManager = NSFileManager.defaultManager()
    var docInteractionController:UIDocumentInteractionController!
    var tableView:UITableView!
    var documnets:[String]! //path string
    var documentURLs:[NSURL]! //path URL
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImportDB()//

        setUpDocPathAndURL()//
        
        self.tableView = UITableView(frame: self.view.frame, style:.Plain)
        self.tableView.separatorStyle = .None
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 100
        self.view.addSubview(tableView)
        
    }

    //MARK: DocInteractionController & DocPathAndURL
    func setUpDocInteractionController(url:NSURL){
        if docInteractionController == nil {
            docInteractionController = UIDocumentInteractionController(URL: url)
        }else {
            docInteractionController.URL = url
        }
    }
    func setUpDocPathAndURL(){
        let support = supportFileDirectory()
        do {
            self.documnets = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(support.path!)
        }catch{
            print(error)
        }
        let urls = try! NSFileManager.defaultManager().contentsOfDirectoryAtURL(support, includingPropertiesForKeys: [], options:.SkipsHiddenFiles)
        self.documentURLs = urls
        print(urls.count)
    }
       //MARK: UITableViewDatasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.documentURLs.count
    }
    
    //MARK: UITableViewDelegate
    // header
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.headerViewForSection(section)
        let rect = tableView.rectForHeaderInSection(section)
        let titleLable = UILabel(frame: rect)
        titleLable.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        
        titleLable.textAlignment = .Center
        headerView?.addSubview(titleLable)
        titleLable.text = "本地文档"
        titleLable.textColor = UIColor.blueColor().colorWithAlphaComponent(0.7)
            return titleLable
       }
 
    // cell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 58.0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("DocumentCell")
        if cell == nil {
            cell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"DocumentCell")
        }
        cell?.textLabel?.text = self.documentURLs[indexPath.row].lastPathComponent
        cell?.textLabel?.textAlignment = .Natural
        
        /// detailLable
        cell?.detailTextLabel?.textAlignment = .Justified
        cell?.detailTextLabel?.baselineAdjustment = .None
        cell?.detailTextLabel?.textColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
        self.setUpDocInteractionController(self.documentURLs[indexPath.row])
        let dic  = try! fileManager.attributesOfItemAtPath((docInteractionController.URL?.path)!)as NSDictionary
        //filesize 和 creatDate
        let fileSize = dic[NSFileSize]?.integerValue
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        let creatDate:NSDate? = dic.fileCreationDate()
        if fileSize != nil && creatDate != nil {
            let fileSizeStr = NSByteCountFormatter.stringFromByteCount(Int64(fileSize!), countStyle:.File)
            let date = dateFormatter.stringFromDate(creatDate!)
            cell?.detailTextLabel?.text = "\(fileSizeStr) - \(date)"
        }else {
            
            let date = dateFormatter.stringFromDate(NSDate())
            cell?.detailTextLabel?.text = "\("0bytes") - \(date)"
        }
        
        let iconCount = docInteractionController.icons.count
        if iconCount>0 {
            cell?.imageView?.image = docInteractionController.icons.last
            cell?.imageView?.highlighted = true
        }
        let rect = tableView.rectForRowAtIndexPath(indexPath)
        let frame = CGRect(x: 0, y: rect.size.height-1, width: rect.size.width, height: 1)
        let line = UIView(frame: frame)
        line.backgroundColor = UIColor.grayColor()
        cell?.contentView.addSubview(line)
        
        return cell!
    }
    //select
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let docUrl = self.documentURLs[indexPath.row]
        print("docUrl:\(docUrl)")
        
        // 解析选择的文件夹
        var urls = findHtmlPaperInURL(docUrl)
        if urls != nil {
            let alert = UIAlertController(title: "请输入试卷名称", message:nil, preferredStyle:UIAlertControllerStyle.Alert)
            alert.addTextFieldWithConfigurationHandler({ (textfield) -> Void in
                if let holdText = docUrl.lastPathComponent {
                    textfield.text = holdText
                }else{
                    textfield.text = ""
                }
            })
            let confirm = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                if let title = alert.textFields?.first?.text {
                    print(title)
                    //点击'确定'开始导入
                    self.ImportDBWithURLs(urls, title: title)
                }
            })
            
            let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                    urls = nil
            })
            alert.addAction(confirm)
            alert.addAction(cancel)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    //MARK: FileSupport
    func supportFileDirectory() -> NSURL {
        let supportDir = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let support = supportDir.first!.URLByAppendingPathComponent("UserExamDocuments")
        do{
            try NSFileManager.defaultManager().createDirectoryAtURL(support, withIntermediateDirectories: true, attributes: nil)
        }catch{
            print(error)
        }
        print(support)
        return support
    }
    func findHtmlPaperInURL(paperURL:NSURL) -> [NSURL]?{
        print("Find Html ............")
        var urls:[NSURL]?
        let keys = [NSURLIsPackageKey,NSURLIsDirectoryKey,NSURLLocalizedNameKey]
        let contents = try! fileManager.contentsOfDirectoryAtURL(paperURL, includingPropertiesForKeys: keys, options: [.SkipsHiddenFiles,.SkipsSubdirectoryDescendants])
        for item in contents {
            if let pathExtention = item.pathExtension {
                if pathExtention.caseInsensitiveCompare("html") == .OrderedSame {
                    urls = [NSURL]()
                    urls?.append(item)
                }
            }
        }
        return urls
    }
    func enumrateContents(dirURL:NSURL){
        let keys = [NSURLIsPackageKey,NSURLIsDirectoryKey,NSURLLocalizedNameKey]
        let enumrator = NSFileManager.defaultManager().enumeratorAtURL(dirURL, includingPropertiesForKeys: keys, options:[.SkipsHiddenFiles,.SkipsPackageDescendants]) { (url, error) -> Bool in
            return true
        }
        if enumrator != nil {
            for aUrl in enumrator! {
                let url = aUrl as! NSURL
                var localizedName:AnyObject? = nil
                try! url.getResourceValue(&localizedName, forKey: NSURLLocalizedNameKey)
            }
        }
        
    }
    //MARK: Test importing & fetching data
    func ImportDBWithURLs(urls:[NSURL]?,title:String){
        if urls != nil {
            for aURL in urls! {
                XZPaperParsingService().parseHTML(aURL,title: title)
                CoreDataStack.sharedCoreDataStack.saveContext()
            }
        }
        
        
    }
    func fetchImportDB(){
        let fetch = NSFetchRequest(entityName:EAImportQuestion)
        do {
            let arr = try CoreDataStack.sharedCoreDataStack.mainQueueContext.executeFetchRequest(fetch)
            print("-----\(arr.count)-----")
            
            for ques in arr {
                let temp = ques as! ImportQuestion
                print("-----\(temp.sort)-----")
                print("id        :\(temp.id)")
                print("headingid :\(temp.headingid)")
                print("typecode  :\(temp.typecode)")
                print("title     :\(temp.title)")
                
                let opts = temp.options
                if opts != nil {
                    if opts!.count>0 {
                        for opt in opts! {
                            let obj = opt as! ImportQuestionOption
                            print("Option    :\(obj.content)")
                        }
                    }
                }
                print("hasimg    :\(temp.hasimg)")
                print("materialid:\(temp.materialid)")
                print("answer    :\(temp.answer)")
                print("score     :\(temp.score)")
                print("parse     :\(temp.parse)")
            }
        }catch{
            print(error)
        }
    }
    


}
