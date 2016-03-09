//
//  TaskTableViewController.swift
//  school
//
//  Created by 張翔 on 2016/03/09.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit
import Parse

class TaskTableViewController: UITableViewController {
    
    var tasks: [Task] = []
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if PFUser.currentUser() == nil{
            let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let vc: UIViewController = storyboard.instantiateInitialViewController()!
            self.presentViewController(vc, animated: true, completion: nil)
        }else if appDelegate.groupErrordeta != nil{
            alart(ParseError(error: appDelegate.groupErrordeta! as NSError).JapaneseForUser)
            if (appDelegate.groupErrordeta! as NSError).code == 998{
                let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("group")
                self.presentViewController(vc, animated: true, completion: nil)
            }
        }else{
            getTasks()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getTasks(){
        do{
            try tasks = appDelegate.group.getTasks()
        }catch{
            alart(ParseError(error: appDelegate.groupErrordeta! as NSError).JapaneseForUser)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskcell", forIndexPath: indexPath) as! TaskTableViewCell
        cell.title.text = tasks[indexPath.row].title
        return cell
    }
    

    func alart(text: String){
        let alartcontroller: UIAlertController = UIAlertController(title: "", message: text, preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alartcontroller.addAction(ok)
        self.presentViewController(alartcontroller, animated: true, completion: nil)
    }
    
 

   

}
