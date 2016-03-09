//
//  TaskTableViewCell.swift
//  school
//
//  Created by 張翔 on 2016/03/09.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell{
    
    @IBOutlet var title: UILabel!
    @IBOutlet var deadline: UILabel!
    @IBOutlet var comment: UILabel!
    @IBOutlet var createdby: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
