//
//  signupViewController.swift
//  school
//
//  Created by 張翔 on 2016/01/20.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit
import Parse

class signupViewController: UIViewController {
    
    @IBOutlet var mail: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var pass1: UITextField!
    @IBOutlet var pass2: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func button(){
        if mail.text == ""{
            alart("メールアドレスを入力してください")
        }else if isValidEmail(mail.text!) == false{
            alart("メールアドレスが無効です")
        }else if name.text == ""{
            alart("ユーザー名を入力してください")
        }else if pass1.text == ""{
            alart("パスワードを入力してください")
        }else if pass1.text != pass2.text{
            alart("もう一度パスワードを確認してください")
            pass1.text = nil
            pass2.text = nil
        }else{
            toSignup()
        }
    }
    
    //メールアドレスチェック
    func isValidEmail(string: String) -> Bool {
        print("validate calendar: \(string)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(string)
        return result
    }
    
    //アラート表示
    func alart(text: String){
        let alartcontroller: UIAlertController = UIAlertController(title: "", message: text, preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alartcontroller.addAction(ok)
        self.presentViewController(alartcontroller, animated: true, completion: nil)
    }
    
    //サインアップ処理
    func toSignup(){
        let user: PFUser = PFUser()
        
        user.username = mail.text
        user.email = mail.text
        user.password = pass1.text
        user["name"] = name.text
        
        user.signUpInBackgroundWithBlock { (succeeded, aerror) -> Void in
            if aerror != nil{
                print(aerror)
                let errorManeger = ParseError(error: aerror)
                self.alart(errorManeger.JapaneseForUser)
                
                

            }else{
                self.performSegueWithIdentifier("singupToGroupWhich", sender: nil)
            }
        }
        
                
    }
    

   
}
