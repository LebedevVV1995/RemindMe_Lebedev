//
//  PopOverViewController.swift
//  RemindMe_Lebedev
//
//  Created by Владимир on 09/10/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

import UIKit

class PopOverViewController: ViewController{
    var listTitle: String = ""
    var remindTitle: String = ""
    
    @IBOutlet weak var popVCTextField: UITextField!
    @IBOutlet weak var popDetVCTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            listTitle = popVCTextField.text!
        }
        if segue.identifier == "doneDetailSegue"{
            remindTitle = popDetVCTextField.text!
        }
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
