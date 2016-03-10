//
//  InputInviteKeyViewController.swift
//  school
//
//  Created by 張翔 on 2016/02/24.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit
import Parse

class InputInviteKeyViewController: UIViewController {
    
    @IBOutlet var textfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alart(text: String){
        let alartcontroller: UIAlertController = UIAlertController(title: "", message: text, preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alartcontroller.addAction(ok)
        self.presentViewController(alartcontroller, animated: true, completion: nil)
    }

    
    @IBAction func button(){
        if textfield.text == ""{
            alart("入力してください")
        }else{
            do{
                try GroupManeger().connectUserByInviteKey(PFUser.currentUser()!, key: textfield.text!)
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.getGroup()
                    NSNotificationCenter.defaultCenter().postNotificationName("MyNotification", object: nil)
                })
            }catch{
                let parseError = ParseError(error: error as NSError)
                alart(parseError.JapaneseForUser)
            }
        }
    }
    
    

}
