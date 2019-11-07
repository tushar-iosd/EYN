//
//  SecondViewController.swift
//  Appecules
//
//  Created by admin on 27/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class UserDataVC: UIViewController {

    @IBOutlet weak var dataTableView: UITableView!
    
    var names: [String] = [] //names is a mutable array holding string values
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationView(barType:appeculesScreen.OrderHistory)
        title = "The List"
        dataTableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "UserDataCell")

    }

    @IBAction func buttonAction(_ sender: Any) {
        addName()
    }
}

extension UserDataVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataCell",
                                          for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    func addName() {
        let alert = UIAlertController(title: "Name of User",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        guard let textField = alert.textFields?.first,
                                            let nameToSave = textField.text else {
                                                return
                                        }
                                        self.names.append(nameToSave)
                                        self.dataTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
       UIApplication.visibleViewController.present(alert, animated: true)
    }
}
