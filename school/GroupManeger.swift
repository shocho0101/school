//
//  GroupManeger.swift
//  school
//
//  Created by 張翔 on 2016/02/03.
//  Copyright © 2016年 sho. All rights reserved.
//

import Foundation
import Parse





class Group: PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var pass: Int
    @NSManaged var member: PFRelation
    @NSManaged var tasks: PFRelation
    
    var memberObjects: [PFUser]!
    var tasksObjects: [Task]!
    
    var inviteKey: String{
        return self.objectId! + "-" + String(pass)
    }
    
    
    override class func initialize(){
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken){
            self.registerSubclass()
        }
    }
    class func parseClassName() -> String {
        return "group"
    }
    
    func getRelationObjecs() throws{
        let memberQuery = member.query()
        do{
            memberObjects = try memberQuery.findObjects() as! [PFUser]
        }
        let tasksQuery = tasks.query()
        do{
            tasksObjects = try tasksQuery.findObjects() as! [Task]
            for task in tasksObjects{
                let query = task.createdBy.query()
                do{
                    task.createdByName = try query.findObjects()[0]["name"] as! String
                }
            }

        }
    }
    
    func reload() throws{
        do{
            try self.fetch()
            try self.getRelationObjecs()
        }
    }
    
    func changeInviteKeyAndReload() throws{
        pass = Int(arc4random())
        do{
            try self.reload()
            try self.save()
            try self.reload()
        }
    }
    
    func connectTaskAndReload(task: Task) throws{
        let relation = self.relationForKey("tasks")
        relation.addObject(task)
        do{
            try self.reload()
            try self.save()
            try self.reload()
        }
    }
    
    func connectUserAndReload(user: PFUser) throws{
        let relation = self.relationForKey("member")
        relation.addObject(user)
        do{
            try self.reload()
            try self.save()
            try self.reload()
        }
    }
}

class GroupManeger {
    init(){
    }
    func findGroup() throws -> Group{
        let group: Group!
        let query = PFQuery(className: "group")
        var objectArray: [PFObject] = []
        query.whereKey("member", equalTo: PFUser.currentUser()!)
        do{
            try objectArray = query.findObjects()
        }
        if objectArray.isEmpty == true{
            throw NSError(domain: "school", code: 998, userInfo: nil)
        }else{
            group = objectArray[0] as! Group
            do{
                try group.getRelationObjecs()
            }
        }
        return group
    }
    
    func connectUserByInviteKey(user: PFUser, key: String) throws -> Group{
        let group: Group!
        let array = key.componentsSeparatedByString("-")
        let groupID = array[0]
        let pass = array[1]
        var objectArray:[PFObject] = []
        let query = PFQuery(className: "group")
        query.whereKey("objectId", equalTo: groupID)
        do{
            try objectArray = query.findObjects()
        }
        if objectArray.isEmpty == false{
            group = objectArray[0] as! Group
            if group.pass == Int(pass){
                let relation = group.relationForKey("member")
                relation.addObject(user)
                do{
                    try group.save()
                    try group.reload()
                }
            }else{
                throw NSError(domain: "school", code: 999, userInfo: nil)
            }
        }else{
            throw NSError(domain: "school", code: 999, userInfo: nil)
        }
        
        return group
    }
    
    func createGroup(name: String) throws{
        let group: Group = Group()
        group.name = name
        group.pass = Int(arc4random())
        let relation: PFRelation = group.member
        relation.addObject(PFUser.currentUser()!)
        do{
            try group.save()
        }
    }
    
}


//古いやつ

//class Group{
//    var object: PFObject!
//
//    var name: String{
//        get{
//            if object == nil{
//                return "nil"
//            }else{
//                return object["name"] as! String
//            }
//        }
//        set{
//            if object != nil{
//                object["name"] = newValue
//            }
//        }
//    }
//
//    var inviteKey: String{
//        get{
//            if object == nil{
//                return "nil"
//            }else{
//                return object.objectId! + "-" + String(object["pass"])
//            }
//        }
//    }
//
//    init(){
//
//    }
//
//    //userのグループを取得
//    func getGroup(user: PFUser) throws{
//
//        let query = PFQuery(className: "group")
//        var objectArray: [PFObject] = []
//        query.whereKey("member", equalTo: user)
//        do{
//            try objectArray = query.findObjects()
//        }
//        if objectArray.isEmpty == true{
//            throw NSError(domain: "school", code: 998, userInfo: nil)
//        }else{
//            object = objectArray[0]
//        }
//
//
//    }
//
//    //グループを作成
//    func createGroupAndReturnError(groupname: String) -> NSError?{
//        let newGroup: PFObject = PFObject(className: "group")
//        var returnError: NSError? = nil
//        let pass = arc4random()
//        newGroup["name"] = groupname
//        newGroup["pass"] = Int(pass)
//        let relation = newGroup.relationForKey("member")
//        let user = PFUser.currentUser()
//        relation.addObject(user!)
//
//        do{
//            try newGroup.save()
//        }catch{
//            returnError = error as NSError
//        }
//
//        return returnError
//    }
//
//    //グループキーからユーザーを結びつけ
//    func connectUserByInvitekey(user: PFUser!, key: String!) throws{
//        let array = key.componentsSeparatedByString("-")
//        let groupID = array[0]
//        let pass = array[1]
//        var objectArray:[PFObject] = []
//        let query = PFQuery(className: "group")
//        query.whereKey("objectId", equalTo: groupID)
//        do{
//            try objectArray = query.findObjects()
//        }
//        if objectArray.isEmpty == false {
//            object = objectArray[0]
//            if String(object["pass"]) == pass{
//                let relation = object.relationForKey("member")
//                relation.addObject(user)
//                do{
//                    try object.save()
//                }
//            }else{
//                throw NSError(domain: "school", code: 999, userInfo: nil)
//            }
//        }else{
//            throw NSError(domain: "school", code: 999, userInfo: nil)
//        }
//
//
//    }
//
//
//    //グループのメンバー取得
//    func getMember() throws -> [PFUser]{
//        var member: [PFUser] = []
//        if  object == nil{
//            throw NSError(domain: "school", code: 9999, userInfo: nil)
//        }else{
//            let relation: PFRelation = (object["member"])! as! PFRelation
//            let query = relation.query()
//            do{
//                member = try query.findObjects() as! [PFUser]
//            }
//        }
//    return member
//    }
//
//    //グループキー変更
//    func changeInviteKey() throws{
//        object["pass"] = Int(arc4random())
//        do{
//            try object.save()
//            try getGroup(PFUser.currentUser()!)
//        }
//    }
//
//    //グループのtaskを取得
//    func getTasks() throws -> [Task]{
//        var taskObjects: [Task] = []
//        if  object == nil{
//            throw NSError(domain: "school", code: 9999, userInfo: nil)
//        }else{
//            let relation: PFRelation = (object["tasks"])! as! PFRelation
//            let query = relation.query()
//            do{
//                taskObjects = try query.findObjects() as! [Task]
//                for task in taskObjects{
//                    let query = task.createdBy.query()
//                    do{
//                        task.createdByName = try query.findObjects()[0]["name"] as! String
//                    }
//                }
//            }
//        }
//
//
//
//        return taskObjects
//    }
//
//    //taskを結びつけ
//    func connectTask(task: Task){
//        let relation = object.relationForKey("tasks")
//        relation.addObject(task)
//        object.saveInBackgroundWithBlock { (succeed, error) -> Void in
//            if error != nil{
//
//            }else{
//                do{
//                    try self.getGroup(PFUser.currentUser()!)
//                }catch{
//
//                }
//            }
//        }
//    }
//
//
//
//}


