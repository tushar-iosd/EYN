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
        self.customNavigationView(barType:appeculesScreen.AddUser)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
