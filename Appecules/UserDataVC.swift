//
//  SecondViewController.swift
//  Appecules
//
//  Created by admin on 27/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData
class UserDataVC: UIViewController {

    @IBOutlet weak var dataTableView: UITableView!
    var selectedCell: IndexPath?
 //   var names: [String] = [] //names is a mutable array holding string values
    var people: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationView(barType:appeculesScreen.OrderHistory)
        title = "The List"
        dataTableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "UserDataCell")

    }

    @IBAction func buttonAction(_ sender: Any) {
        addName(fromMoreAction: false)
    }
}

extension UserDataVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataCell",
                                                 for: indexPath)
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        return cell
    }
    func selectCell(indexPath: IndexPath) {
        selectedCell = indexPath
        self.dataTableView?.dequeueReusableCell(withIdentifier: "UserDataCell")
        addName(fromMoreAction: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Entry Deleted")
            people.remove(at: indexPath.row)
            self.dataTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // Write action code for the trash
        let TrashAction = UIContextualAction(style: .destructive, title:  "Trash", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("TrashAction  ...")
            self.people.remove(at: indexPath.row)
           // self.dataTableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        })
        TrashAction.backgroundColor = .red
        
        // Write action code for the Flag
        let FlagAction = UIContextualAction(style: .normal, title:  "Flag", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
           let cell =  self.dataTableView.cellForRow(at: indexPath)
            if cell?.backgroundColor == .red{
                cell?.backgroundColor = .white
            } else {
                cell?.backgroundColor = .red
            }
            print("FlagAction ...")
            success(true)
        })
        FlagAction.backgroundColor = .orange
        // Write action code for the More
        let MoreAction = UIContextualAction(style: .normal, title:  "More", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("MoreAction ...")
            self.selectCell(indexPath: indexPath)
            success(true)
        })
        MoreAction.backgroundColor = .gray
        
        let config = UISwipeActionsConfiguration(actions: [TrashAction,FlagAction,MoreAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

// Core Data Methods
extension UserDataVC {
    func addName(fromMoreAction: Bool) {
        let addUserAlert = UIAlertController(title: "Name of User",
                                             message: "Add a new name",
                                             preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            
            guard let textField = addUserAlert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            if fromMoreAction {
                self.save(name: nameToSave, add: false)
            } else {
                self.save(name: nameToSave, add: true)
                
            }
            self.dataTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        addUserAlert.addTextField()
        addUserAlert.addAction(saveAction)
        addUserAlert.addAction(cancelAction)
        UIApplication.visibleViewController.present(addUserAlert, animated: true)
    }
    
    //Function to save Names into Core Data Managed Object and check of the Performed Action is Add or Edit
    func save(name: String, add : Bool) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
            if add {
                people.append(person)
            } else {
                people.remove(at: selectedCell!.row)
                people.append(person)
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
