//
//  StartViewController.swift
//  school
//
//  Created by 張翔 on 2016/02/10.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit
import Parse

class StartViewController: UIViewController {
    
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let group: Group = Group()
        let error = group.getGroup()
        if error != nil{
            print(error)
            let parseError = ParseError(error: error)
            alart(parseError.JapaneseForUser)
        }else{
            label.text = group.inviteKey
        }

    }
    
    @IBAction func copyto(){
        let board = UIPasteboard.generalPasteboard()
        board.setValue(label.text!, forPasteboardType: "public.text")
    }
    //アラート表示
    func alart(text: String){
        let alartcontroller: UIAlertController = UIAlertController(title: "", message: text, preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alartcontroller.addAction(ok)
        self.presentViewController(alartcontroller, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func start(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        self.presentViewController(vc!, animated: true, completion: nil)
    }
    

   
}
