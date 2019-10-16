//
//  MainTableViewCell.swift
//  RemindMe_Lebedev
//
//  Created by Владимир on 10/10/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var listLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
