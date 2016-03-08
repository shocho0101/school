//
//  TaskManeger.swift
//  school
//
//  Created by 張翔 on 2016/03/08.
//  Copyright © 2016年 sho. All rights reserved.
//

import Foundation
import Parse

class task {
    var object: PFObject
    init(aobject: PFObject){
        object = aobject
    }
    
    convenience init(title: String, deadline: NSDate, comment: String){
        let aobject = PFObject(className: "task")
        aobject["title"] = title
        aobject["deadline"] = deadline
        aobject["comment"] = comment
        
        self.init(aobject: aobject)

    }
    
}