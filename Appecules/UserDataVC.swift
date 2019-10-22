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
     // self.registerTableCell()
        registerTableCell(tableView: dataTableView, tableViewCell: "UserDataCell")
    }
    @IBAction func buttonAction(_ sender: Any) {
    self.navigate(newControl: viewControllers.AddUser, StoryBoard: storyBoardID.Main.rawValue)
      // addName(fromMoreAction: false)
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchDataOfUser()
        dataTableView.reloadData()
    }
}

extension UserDataVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = people[indexPath.row]
        let cell: UserDataCell = tableView.dequeueReusableCell(withIdentifier: "UserDataCell",
                                                 for: indexPath) as! UserDataCell
        guard let personName = person.value(forKey: "name") else {
            return cell
        }
        cell.nameLbl.text = personName as? String
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
       // selectedCell = indexPath
        UserDetailVC.people = [ people[indexPath.row]]
        navigate(newControl: viewControllers.UserDetails, StoryBoard: storyBoardID.Main.rawValue)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Write action code for the trash
        let TrashAction = UIContextualAction(style: .destructive, title:  "Trash", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("TrashAction  ...")
            self.deleteData(entry: self.people[indexPath.row])
            success(true)
        })
        TrashAction.backgroundColor = .red
        
        // Write action code for the Flag
        let FlagAction = UIContextualAction(style: .normal, title:  "Flag", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            let cell =  self.dataTableView.cellForRow(at: indexPath) as! UserDataCell
            if cell.backgroundColor == .red{
                cell.backgroundColor = .white
            } else {
                cell.backgroundColor = .red
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let FlagAction = UIContextualAction(style: .normal, title:  "No Clue", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
        })
        FlagAction.backgroundColor = .green
        let config = UISwipeActionsConfiguration(actions: [FlagAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
  /*  func registerTableCell() {
            let userDataCell = UINib(nibName: "UserDataCell", bundle: nil)
          self.dataTableView.register(userDataCell, forCellReuseIdentifier: "UserDataCell")
    }*/
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
                self.deleteData(entry: self.people[(selectedCell?.row)!])
                //[selectedCell!.row]
                people.remove(at: selectedCell!.row)
                people.append(person)
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Fecth All The Data from Core Data of User
    func fetchDataOfUser() {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        //3
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // Delete any Entry with NSMANagedObject
    func deleteData(entry: NSManagedObject) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context =
            appDelegate.persistentContainer.viewContext
        // context.delete(myData[indexPath.row] as NSManagedObject)
        context.delete(entry as NSManagedObject)
      
       appDelegate.saveContext()
    }
   
    // It Will Delete All the Data from Given Entity
    func deleteAllData(entityName: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context =
            appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            let result =  try context.execute(request)
            print("Delete All Result",result)
        } catch let error as NSError {
            print("Error in fetch :\(error)")
        }
    }
    
    func getData() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        let sort = NSSortDescriptor(key: #keyPath(Person.empID), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do {
              let result =  try context.execute(fetchRequest)
          //  appDelegate.saveContext()
         //   people = result
             people = try context.fetch(fetchRequest)
             self.dataTableView.reloadData()
            print("ResultOFSort",result)
          //  Person = try context.fetch(fetchRequest)
        } catch {
            print("Cannot fetch Expenses")
        }
    }
}
