//
//  UserDetailVC.swift
//  Appecules
//
//  Created by admin on 22/10/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData
class UserDetailVC: UIViewController {

    static var userDetails = Dictionary<String, Any>()
    static var people: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        self.customNavigationView(barType:appeculesScreen.AddUser)
       
    }
}
