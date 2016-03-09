//
//  TaskManeger.swift
//  school
//
//  Created by 張翔 on 2016/03/08.
//  Copyright © 2016年 sho. All rights reserved.
//

import Foundation
import Parse

class Task: PFObject, PFSubclassing {
    
    @NSManaged var title: String
    @NSManaged var deadline: NSDate
    @NSManaged var comment: String?
    @NSManaged var createdBy: PFRelation
    
    override class func initialize(){
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken){
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String {
        return "task"
    }
    
    func post() {
        createdBy.addObject(PFUser.currentUser()!)
        self.saveInBackgroundWithBlock { (succeed, error) -> Void in
            if error != nil{
                let notification: NSNotification = NSNotification(name: "posterror", object: nil, userInfo: ["code": error!.code])
                NSNotificationCenter.defaultCenter().postNotification(notification)
            }else{
                print(self.objectId)
                let group: Group =  Group()
                do{
                    try group.getGroup(PFUser.currentUser()!)
                }catch let caughtError as NSError{
                    let notification: NSNotification = NSNotification(name: "posterror", object: nil, userInfo: ["code": caughtError.code])
                    NSNotificationCenter.defaultCenter().postNotification(notification)
                }
                group.connectTask(self)
            }
            
        }
        self.saveInBackground()
        
    }
    
    
        
}