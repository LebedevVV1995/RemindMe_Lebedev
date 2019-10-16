//
//  DetailTableViewCell.swift
//  RemindMe_Lebedev
//
//  Created by Владимир on 10/10/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var remindTextField: UITextField!
    @IBAction func remindEdit(_ sender: UITextField) {
//        DetailViewController.setEditing(DetailTableViewCell)
        
//        self.navigationItem.rightBarButtonItem?.image = nil as? DetailViewController
//        self.editButtonItem.title = "Готово" as? DetailViewController
    }
    @IBAction func remindEditOff(_ sender: UITextField) {
        
    }
    @IBOutlet weak var infoButton: UIButton!
    @IBAction func infoButtonAction(_ sender: UIButton) {
    }
    @IBAction func checkBox(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
