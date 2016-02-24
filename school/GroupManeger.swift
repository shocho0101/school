//
//  GroupManeger.swift
//  school
//
//  Created by 張翔 on 2016/02/03.
//  Copyright © 2016年 sho. All rights reserved.
//

import Foundation
import Parse

enum GroupError: ErrorType{
    case falseInviteKye
}

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
        
        return returnError
    }
    
    func connectUserByInvitekey(user: PFUser!, key: String!) throws{
        let array = key.componentsSeparatedByString("-")
        let groupID = array[0]
        let pass = array[1]
        let query = PFQuery(className: "group")
        query.whereKey("objectId", equalTo: groupID)
        do{
            try object = query.findObjects()[0]
        }
        if object != nil{
            if String(object["pass"]) == pass{
                let relation = object.relationForKey("member")
                relation.addObject(user)
                do{
                    try object.save()
                }
            }else{
                throw GroupError.falseInviteKye
            }
        }
        
    }

}

    
    

