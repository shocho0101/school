//
//  FirstViewController.swift
//  school
//
//  Created by 張翔 on 2015/12/31.
//  Copyright © 2015年 sho. All rights reserved.
//

import UIKit
import Parse

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(){
        PFUser.logOut()
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let vc: UIViewController = storyboard.instantiateInitialViewController()!
        self.presentViewController(vc, animated: true, completion: nil)

    }


}

