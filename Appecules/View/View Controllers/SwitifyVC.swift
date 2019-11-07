//
//  SwitifyVC.swift
//  Appecules
//
//  Created by admin on 05/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class SwitifyVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationView(barType:AppeculesScreen.Swiftify)
        // Do any additional setup after loading the view.
        runScenario()
    }
    
    func runScenario() {
        _  = User(name: "John")
    }

}

class User {
    let name: String
    init(name: String) {
        self.name = name
        print("User \(name) was initialized")
    }
    
    deinit {
        print("Deallocating user named: \(name)")
    }
}


