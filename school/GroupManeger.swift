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
        get{
            if object == nil{
                return "nil"
            }else{
                return object["name"] as! String
            }
        }
        set{
            if object != nil{
                object["name"] = newValue
            }
        }
    }
    
    var inviteKey: String{
        get{
            if object == nil{
                return "nil"
            }else{
                return object.objectId! + "-" + String(object["pass"])
            }
        }
    }
    
    init(){
        
    }
    
    
    func getGroup(user: PFUser) throws{
        
        let query = PFQuery(className: "group")
        query.whereKey("member", equalTo: user)
        do{
            try object = query.findObjects()[0]
            print(object)
        }
        
    
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
        var objectArray:[PFObject] = []
        let query = PFQuery(className: "group")
        query.whereKey("objectId", equalTo: groupID)
        do{
            try objectArray = query.findObjects()
        }
        if objectArray.isEmpty == false  && String(object["pass"]) == pass{
            object = objectArray[0]
            let relation = object.relationForKey("member")
            relation.addObject(user)
            do{
                try object.save()
            }
        }else{
            throw NSError(domain: "school", code: 999, userInfo: nil)
        }
        
        
    }
    
    func getMember() throws -> [PFUser]{
        var member: [PFUser] = []
        if  object == nil{
            throw NSError(domain: "school", code: 9999, userInfo: nil)
        }else{
            let relation: PFRelation = (object["member"])! as! PFRelation
            let query = relation.query()
            do{
                member = try query.findObjects() as! [PFUser]
            }
        }
    return member
    }

}


