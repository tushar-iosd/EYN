//
//  NavigationBar.swift
//  Appecules
//
//  Created by admin on 27/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
enum appeculesScreen: String {
    case Home = "Home"
    case OrderHistory = "Order History"
    case AddUser = "Add User"
    case UserDetail = "User Detail"
}



class NavigationBar: UIView {
    
    @IBOutlet weak var leftButtonItem: UIButton!
    @IBOutlet weak var rightButtonItem: UIButton!
    var barType : appeculesScreen = .Home {
        didSet{
            setBarType()
        }
    }
    
    func setBarType(){
        let color : UIColor?
        switch barType {
        case .Home:
            leftButtonItem.isHidden = true
            rightButtonItem.isHidden = true
            color = UIColor.red
        case .OrderHistory:
            leftButtonItem.setTitle("Back", for: .normal)
            leftButtonItem.titleLabel?.textColor = UIColor.white
            rightButtonItem.setTitle("+", for: .normal)
            rightButtonItem.titleLabel?.textColor = UIColor.white
            color = UIColor.green
        case .AddUser:
            leftButtonItem.setTitle("Back", for: .normal)
            leftButtonItem.titleLabel?.textColor = UIColor.white
            rightButtonItem.isHidden = true
            color = UIColor.purple
        case .UserDetail:
            leftButtonItem.setTitle("Back", for: .normal)
            leftButtonItem.titleLabel?.textColor = UIColor.white
            rightButtonItem.isHidden = true
            color = UIColor.purple
        }
        self.backgroundColor = color
    }
    
    class func loadFromNib()-> UIView{
        let nib = UINib(nibName: "NavigationBar", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func leftButtonAction(_ sender: Any) {
        switch barType {
        case .Home:
            print("Homed")
        default:
            UIApplication.visibleViewController.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        switch barType {
        case .Home:
            print("Homed")
        case .OrderHistory:
            print("Add User Action")
        default:
            UIApplication.visibleViewController.navigationController?.popViewController(animated: true)
        }
    }
    
}
