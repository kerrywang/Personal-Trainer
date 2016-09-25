//
//  HistoryTableViewCell.swift
//  Personal Trainer
//
//  Created by kaiyue wang on 7/24/16.
//  Copyright © 2016 kaiyuewang. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var workOutDate: UILabel!
    @IBOutlet weak var workOutType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
