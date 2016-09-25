//
//  SetTableViewCell.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 7/27/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

import UIKit

class SetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var TheImage: UIImageView!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var setNum: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
