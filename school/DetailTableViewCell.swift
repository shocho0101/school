//
//  DetailTableViewCell.swift
//  school
//
//  Created by 張翔 on 2016/03/14.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var deadline: UILabel!
    @IBOutlet var comment: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        var frame = comment.frame
        frame.size.height = comment.contentSize.height
        comment.frame = frame
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
