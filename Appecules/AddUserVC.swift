//
//  AddUserVC.swift
//  Appecules
//
//  Created by admin on 21/10/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData

class AddUserVC: UIViewController {

    @IBOutlet weak var addUserTable: UITableView!
    var rowCount : Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        self.customNavigationView(barType:appeculesScreen.AddUser)
      
        registerTableCell(tableView: addUserTable, tableViewCell: "AddUserCell")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addEntryBtnAction(_ sender: Any) {
        addEntry()
    }
    @IBAction func removeEntryBtnAction(_ sender: Any) {
        removeEntry()
    }
    
    @IBAction func saveEntryBtnAction(_ sender: Any) {
        var entryDict = [String: String]()
        var cell : AddUserCell!
        for index in 0..<rowCount {
            let indexPath = IndexPath(row: index, section:0)
            cell = addUserTable.cellForRow(at: indexPath) as? AddUserCell
                let name: String = cell.fullName.text ?? " "
             let contact: String = cell.contactNumber.text ?? " "
             let empID: String = cell.empID.text ?? " "
             let technology: String = cell.technology.text ?? " "
             entryDict = ["name":name,"contact":contact,"empID": empID,"technology":technology]
            
            if ((!name.trimmingCharacters(in: .whitespaces).isEmpty )&&(!empID.trimmingCharacters(in: .whitespaces).isEmpty)) {
                // string contains non-whitespace characters
                saveWithCoreData(entityName: "Person", Entries: entryDict) //Globally Declared Function
                // save(name: fullName) // Class Level Function
            } else {
               presentAlertController(title: ApplicationHeaders.appName, message: AppAlertMessage.nameBlank, buttons: [AppAlertMessage.okay])
            }
        }
        rowCount = 1
        UIAlertController.showAlert(ApplicationHeaders.appName, message: AppAlertMessage.dataSaved, buttons: [AppAlertMessage.okay]) { (alert, index) in
           self.popOrDismissViewController(true)
        }
    }
    
    
    //Function to save Names into Core Data Managed Object and check of the Performed Action is Add or Edit
    func save(name: String) {
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
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func addEntry(){
        rowCount += 1
        self.addUserTable.beginUpdates()
        let indexPath = IndexPath(row: rowCount - 1, section:0)
        addUserTable.insertRows(at: [indexPath], with: .automatic)
        self.addUserTable.endUpdates()
         view.endEditing(true)
    }
  
    func removeEntry(){
        if rowCount > 1 {
            rowCount -= 1
            self.addUserTable.beginUpdates()
            let indexPath = IndexPath(row: rowCount, section:0)
            self.addUserTable.deleteRows(at:[indexPath], with: .automatic)
            self.addUserTable.endUpdates()
        }
    }
}
extension AddUserVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddUserCell", for: indexPath) as! AddUserCell
        return cell
    }
    
    
}
