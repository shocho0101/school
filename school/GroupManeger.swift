//
//  GroupManeger.swift
//  school
//
//  Created by 張翔 on 2016/02/03.
//  Copyright © 2016年 sho. All rights reserved.
//

import Foundation
import Parse

class Group{
    var object: PFObject!
    
    var name: String{
        if object == nil{
            return "nil"
        }else{
            return object["name"] as! String
        }
    }
    
    var inviteKey: String{
        if object == nil{
            return "nil"
        }else{
            return object.objectId! + "-" + String(object["pass"])
        }
    }
    
    
    
    init(){
        
    }
    
    
    func getGroup() -> NSError?{
        var returnError: NSError? = nil
        
        let query = PFQuery(className: "group")
        let user = PFUser.currentUser()
        query.whereKey("member", equalTo: user!)
        do{
            try object = query.findObjects()[0]
            print(object)
        }catch{
            returnError = error as NSError
        }
        
        return returnError
    }
    
    func createGroupAndReturnError(groupname: String) -> NSError?{
        let newGroup: PFObject = PFObject(className: "group")
        var returnError: NSError? = nil
        let pass = arc4random()
        newGroup["name"] = groupname
        newGroup["pass"] = Int(pass)
        let relation = newGroup.relationForKey("member")
        let user = PFUser.currentUser()
        relation.addObject(user!)
        
        do{
        try newGroup.save()
        }catch{
            returnError = error as NSError
        }
        
//        newGroup.saveEventually{ (bool , error ) -> Void in
//            if error != nil{
//                returnError = error
//                print(error)
//            }else{
//                //グループを検索
//                let getGroupError = self.getGroup()
//                if getGroupError != nil{
//                    returnError = getGroupError
//                }
//            }
//        }
        return returnError
    }

}

    
    

