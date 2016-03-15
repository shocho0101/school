//
//  AddMemberViewController.swift
//  school
//
//  Created by 張翔 on 2016/03/07.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class AddMemberViewController: UIViewController {
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet var textfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.text = appDelegate.group!.inviteKey
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func copyto(){
        let board = UIPasteboard.generalPasteboard()
        board.setValue(textfield.text!, forPasteboardType: "public.text")
    }
    
    @IBAction func changeKey(){
        let alartcontroller: UIAlertController = UIAlertController(title: "", message:"変更すると現在のグループキーは使えなくなります。変更しますか？" , preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "変更", style: .Default) { (action) -> Void in
            SVProgressHUD.show()
            let delay = 0.01 * Double(NSEC_PER_SEC)
            let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                self.change()
            })

        }
        let cancel: UIAlertAction = UIAlertAction(title: "キャンセル", style: .Default) { (action) -> Void in
        }
        alartcontroller.addAction(cancel)
        alartcontroller.addAction(ok)
        
        self.presentViewController(alartcontroller, animated: true, completion: nil)

    }
    
    func change(){
        do{
            try appDelegate.group?.changeInviteKeyAndReload()
        }catch{
            alart(ParseError(error: error as NSError).JapaneseForUser)
        }
        textfield.text = appDelegate.group!.inviteKey
        SVProgressHUD.dismiss()

    }
    
    func alart(text: String){
        let alartcontroller: UIAlertController = UIAlertController(title: "", message: text, preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alartcontroller.addAction(ok)
        self.presentViewController(alartcontroller, animated: true, completion: nil)
    }
    
    

 
}
