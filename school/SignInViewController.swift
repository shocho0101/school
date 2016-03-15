//
//  SignInViewController.swift
//  school
//
//  Created by 張翔 on 2016/02/24.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet var mail: UITextField!
    @IBOutlet var pass: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mail.delegate = self
        pass.delegate = self
        
        mail.becomeFirstResponder()

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
    
    func isValidEmail(string: String) -> Bool {
        print("validate calendar: \(string)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(string)
        return result
    }
    
    @IBAction func button(){
        //チェック
        if mail.text == ""{
            alart("メールアドレスを入力してください")
        }else if pass.text == ""{
            alart("パスワードを入力してください")
        }else if isValidEmail(mail.text!) == false{
            alart("メールアドレスを確認してください")
        }else{
            signin()
        }
        
    }
    
    func signin(){
        PFUser.logInWithUsernameInBackground(mail.text!, password: pass.text!) { (user, error) -> Void in
            if error != nil{
                let parseError = ParseError(error: error)
                self.alart(parseError.JapaneseForUser)
            }else{
                self.dismissViewControllerAnimated(true) { () -> Void in
                    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.getGroup()
                    NSNotificationCenter.defaultCenter().postNotificationName("MyNotification", object: nil)
                    
                }
            }
        }
    }
    
    @IBAction func back(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField{
        case mail:
            pass.becomeFirstResponder()
        case pass:
            button()
        default:
            print("error")
            
        }
        return false
    }

    
    

}
