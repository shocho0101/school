//
//  MemberTableViewController.swift
//  school
//
//  Created by 張翔 on 2016/03/06.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit
import Parse

class MemberTableViewController: UITableViewController {
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "update:", name: "MyNotification", object: nil)
        
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
        reflesh.addTarget(self, action: "update:", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = reflesh
        
        
    }
    
    func update(notification: NSNotification?){
        do{
            try appDelegate.group?.reload()
        }catch{
            alart(ParseError(error: error as NSError).JapaneseForUser)
        }
        tableView.reloadData()
        refreshControl?.endRefreshing()
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
        if appDelegate.group == nil{
            return 0
        }else{
        return (appDelegate.group?.memberObjects.count)!
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MemberTableViewCell
        cell.name.text = appDelegate.group?.memberObjects[indexPath.row]["name"] as? String
        return cell
    }
    
    func alart(text: String){
        let alartcontroller: UIAlertController = UIAlertController(title: "", message: text, preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alartcontroller.addAction(ok)
        self.presentViewController(alartcontroller, animated: true, completion: nil)
    }


}
