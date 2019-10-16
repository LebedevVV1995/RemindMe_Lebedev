//
//  ViewController.swift
//  RemindMe_Lebedev
//
//  Created by Владимир on 08/10/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var categoryNames = [String](remindersCategories.keys)
    var newCategory: String?
    var currentKeys : String = ""
    
    @IBOutlet weak var MyTableView: UITableView!
    @IBOutlet weak var btnPopOver: UIButton!

    @IBAction func btnReloadTable(segue: UIStoryboardSegue) {
        let popupVC = segue.source as! PopOverViewController
        newCategory = popupVC.listTitle
        categoryNames.append(newCategory!)
        remindersCategories[newCategory!] = ["Новое напоминание"]
        self.MyTableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remindersCategories["Личные"] = ["Новое напоминание"]
        remindersCategories["Рабочие"] = ["Новое напоминание"]
        categoryNames = [String](remindersCategories.keys)
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem?.title = "Править"
        self.MyTableView?.tableFooterView = UIView()
        
        DispatchQueue.main.async {
            self.MyTableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as? MainTableViewCell
        cell?.listLable.text = categoryNames[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categoryNames.count == 0 {
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        }
        else {
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        }
        return categoryNames.count
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let elementToMove = categoryNames[fromIndexPath.row]
        categoryNames.remove(at: fromIndexPath.row)
        categoryNames.insert(elementToMove, at: to.row)
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        MyTableView.setEditing(editing, animated: animated)

        if MyTableView.isEditing{
            self.editButtonItem.title = "Готово"
        } else {
            self.navigationItem.rightBarButtonItem?.title = "Править"
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") {
            _, indexPath in
            self.categoryNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let indexPath = self.MyTableView.indexPathForSelectedRow{
                let vc = segue.destination as? DetailViewController
                vc?.currentKeysDetVC = self.categoryNames[indexPath.row]
                vc?.reminders = remindersCategories[vc!.currentKeysDetVC]!
            }
        }
        if segue.identifier == "showPopOver" {
            if let view = segue.destination as? PopOverViewController {
                view.popoverPresentationController?.delegate = self
                view.preferredContentSize = CGSize(width: 250, height: 250)
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "toDetail", sender: indexPath.item)
        self.currentKeys = self.categoryNames[indexPath.row]
    }
}

extension ViewController:UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
