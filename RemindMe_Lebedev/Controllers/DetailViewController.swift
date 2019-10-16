//
//  MyTableViewController.swift
//  RemindMe_Lebedev
//
//  Created by Владимир on 08/10/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {   
    var currentKeysDetVC : String = ""
    var reminders = [String]()
    var newRemind: String = ""    
    
    @IBOutlet weak var MyDetTableView: UITableView!
    @IBOutlet weak var reminTF: UITextField!
    
    @IBAction func renameReminder(_ sender: UITextField) {
        print(reminders)
        let  indexPath = self.MyDetTableView.indexPathForSelectedRow
        let cellChangeText = MyDetTableView.dequeueReusableCell(withIdentifier: "mDetCell", for: indexPath!) as? DetailTableViewCell
        self.reminders[indexPath!.row] = cellChangeText!.remindTextField.text!
        print(reminders)
        self.MyDetTableView.reloadData()
        
    }
    
    @IBAction func btnReloadDetTable(segue: UIStoryboardSegue) {
        let popupDetVC = segue.source as! PopOverViewController
        newRemind = popupDetVC.remindTitle
        reminders.append("\(newRemind)")
        remindersCategories[currentKeysDetVC] = reminders
        self.MyDetTableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = currentKeysDetVC
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: "MoreBtn")
        self.MyDetTableView?.tableFooterView = UIView()

        DispatchQueue.main.async {
            self.MyDetTableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellDet = tableView.dequeueReusableCell(withIdentifier: "mDetCell", for: indexPath) as? DetailTableViewCell
        cellDet?.remindTextField.text = reminders[indexPath.row]
        return cellDet!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        MyDetTableView.setEditing(editing, animated: animated)
        
        if MyDetTableView.isEditing{
            self.navigationItem.rightBarButtonItem?.image = nil
            self.navigationItem.rightBarButtonItem?.title = "Готово"
        } else {
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "MoreBtn")
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") {
            _, indexPath in
            self.reminders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopOver" {
            if let view = segue.destination as? PopOverViewController {
                view.popoverPresentationController?.delegate = self
                view.preferredContentSize = CGSize(width: 250, height: 250)
            }
        }
    }
}

extension DetailViewController:UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
