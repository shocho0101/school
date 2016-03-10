//
//  NewHomeworkViewController.swift
//  school
//
//  Created by 張翔 on 2015/12/31.
//  Copyright © 2015年 sho. All rights reserved.
//

import UIKit
import XLForm
import Parse


class NewHomeworkViewController: XLFormViewController {
    
    struct tag {
        static var name = "name"
        static var deadline = "deadline"
        static var comment = "comment"
        static var onlyMe = "onlyMe"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createForm()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createForm(){
        var form: XLFormDescriptor
        var section1: XLFormSectionDescriptor
        var section2: XLFormSectionDescriptor
        var row: XLFormRowDescriptor
        
        form = XLFormDescriptor()
        
        section1 = XLFormSectionDescriptor.formSection()
        
        row = XLFormRowDescriptor(tag: tag.name, rowType: XLFormRowDescriptorTypeText)
        row.cellConfigAtConfigure["textField.placeholder"] = "名前を入力"
        section1.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: tag.deadline, rowType: XLFormRowDescriptorTypeDateInline, title: "期限")
        row.value = NSDate()
        section1.addFormRow(row)
        
        row = XLFormRowDescriptor(tag: tag.onlyMe, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "自分にだけ表示")
        row.value = false
        section1.addFormRow(row)
        
        section2 = XLFormSectionDescriptor.formSection()
        
        row = XLFormRowDescriptor(tag: tag.comment, rowType: XLFormRowDescriptorTypeTextView)
        row.cellConfigAtConfigure["textView.placeholder"] = "コメントを入力"
        section2.addFormRow(row)
        
        
        form.addFormSection(section1)
        form.addFormSection(section2)
        self.form = form
        
    }
    
    @IBAction func cancel(){
        parentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(){
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        
        //名前の未入力を確認
        if form.formRowWithTag(tag.name)?.value == nil{
            let alart = UIAlertController(title: "名前が空欄です", message: "入力してください", preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alart.addAction(okButton)
            presentViewController(alart, animated: true, completion: nil)
        
        //期限を確認
        }else if calendar.compareDate(form.formRowWithTag(tag.deadline)?.value as! NSDate, toDate: NSDate(), toUnitGranularity: .NSDayCalendarUnit) == .OrderedAscending{
            let alart = UIAlertController(title: "このまま保存しますか？", message: "期限が今日より以前の日付になっています", preferredStyle: .Alert)
            let cancel = UIAlertAction(title: "キャンセル", style: .Default, handler: nil)
            alart.addAction(cancel)
            let ok = UIAlertAction(title: "保存", style: .Default, handler: { (UIAlertAction) -> Void in
                self.savedata()
            })
            alart.addAction(ok)
            presentViewController(alart, animated: true, completion: nil)
        }else{
            savedata()
            dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }
    }
    
    func savedata(){
        let task = Task()
        task.title = form.formRowWithTag(tag.name)?.value as! String
        task.deadline = form.formRowWithTag(tag.deadline)?.value as! NSDate
        task.comment = form.formRowWithTag(tag.comment)?.value as? String
        do{
            try task.post()
        }catch{
            alart(ParseError(error: error as NSError).JapaneseForUser)
        }
        
        
    }
    
    
    //アラート表示
    func alart(text: String){
        let alartcontroller: UIAlertController = UIAlertController(title: "", message: text, preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alartcontroller.addAction(ok)
        self.presentViewController(alartcontroller, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
