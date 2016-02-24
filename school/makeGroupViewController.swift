//
//  makeGroupViewController.swift
//  school
//
//  Created by 張翔 on 2016/02/03.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

class makeGroupViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!

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
        if textField.text == "" {
            alart("グループ名を入力してください。")
        }else{
            let newgroup: Group = Group()
            let error = newgroup.createGroupAndReturnError(textField.text!)
            if error != nil{
                let errorManeger = ParseError(error: error)
                self.alart(errorManeger.JapaneseForUser)
            }else{
                let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewControllerWithIdentifier("groupcreated")
                self.presentViewController(vc, animated: true, completion: nil)
            }
        }
    }
    
    
}
