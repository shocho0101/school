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
    
    var date_formatter: NSDateFormatter = NSDateFormatter()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = appDelegate.group?.name
        
        date_formatter.locale     = NSLocale(localeIdentifier: "ja")
        date_formatter.dateFormat = "MM/ddb"
        
        tableView.tableFooterView = UIView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reflesh", name: "MyNotification", object: nil)

        
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
        cell.deadline.text = date_formatter.stringFromDate((appDelegate.group?.tasksObjects[indexPath.row].deadline)!)
        cell.comment.text = appDelegate.group?.tasksObjects[indexPath.row].comment
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        
        if calendar.isDateInToday((appDelegate.group?.tasksObjects[indexPath.row].deadline)!) == true || calendar.isDateInTomorrow((appDelegate.group?.tasksObjects[indexPath.row].deadline)!) == true{
            cell.deadline.textColor = UIColor.redColor()
            cell.title.textColor = UIColor.redColor()   
        }else if appDelegate.group?.tasksObjects[indexPath.row].deadline.compare(NSDate()) == NSComparisonResult.OrderedAscending{
            cell.title.textColor = UIColor.lightGrayColor()
            cell.deadline.textColor = UIColor.lightGrayColor()

        }
        return cell
    }
    

    func alart(text: String){
        let alartcontroller: UIAlertController = UIAlertController(title: "", message: text, preferredStyle: .Alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alartcontroller.addAction(ok)
        self.presentViewController(alartcontroller, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "taskToDetail"{
        let next: DetailTableViewController = segue.destinationViewController as! DetailTableViewController
        next.task = appDelegate.group?.tasksObjects[(tableView.indexPathForCell(sender as! UITableViewCell)?.row)!]
        }
    }
 

   

}
