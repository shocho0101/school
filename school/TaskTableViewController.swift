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
        }
        
        let reflesh = UIRefreshControl()
        reflesh.addTarget(self, action: "reflesh", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = reflesh
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func reflesh(){
        do{
            try appDelegate.group?.reload()
        }catch{
            alart(ParseError(error: error as NSError).JapaneseForUser)
        }
        tableView.reloadData()
        self.refreshControl?.endRefreshing()
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
        return (appDelegate.group?.tasksObjects.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskcell", forIndexPath: indexPath) as! TaskTableViewCell
        cell.title.text = appDelegate.group?.tasksObjects[indexPath.row].title
        cell.createdby.text = (appDelegate.group?.tasksObjects[indexPath.row].createdByName)! + "が投稿しました"
        cell.comment.text = appDelegate.group?.tasksObjects[indexPath.row].comment
        return cell
    }
    

    func alart(text: String){
        let alartcontroller: UIAlertController = UIAlertController(title: "", message: text, preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alartcontroller.addAction(ok)
        self.presentViewController(alartcontroller, animated: true, completion: nil)
    }
    
 

   

}
