//
//  makeGroupViewController.swift
//  school
//
//  Created by 張翔 on 2016/02/03.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

class makeGroupViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.becomeFirstResponder()
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
            do{
            try GroupManeger().createGroup(textField.text!)
            self.performSegueWithIdentifier("makeGroupToStart", sender: nil)
            }catch{
                alart(ParseError(error: error as NSError).JapaneseForUser)
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        button()
        return false
    }
    
    @IBAction func back(){
        navigationController?.popViewControllerAnimated(true)
    }

    
    
    
}
