//
//  UIViewController.swift
//  Appecules
//
//  Created by admin on 27/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit
import CoreData
extension UIViewController {
    
 
    func isPresentedModally() -> Bool {
        return self.presentingViewController?.presentedViewController == self
    }
    
    func findContentViewControllerRecursively() -> UIViewController {
        var childViewController: UIViewController?
        if self is UITabBarController {
            childViewController = (self as? UITabBarController)?.selectedViewController
        } else if self is UINavigationController {
            childViewController = (self as? UINavigationController)?.topViewController
        } else if self is UISplitViewController {
            childViewController = (self as? UISplitViewController)?.viewControllers.last
        } else if self.presentedViewController != nil {
            childViewController = self.presentedViewController
        }
        let shouldContinueSearch: Bool = (childViewController != nil) && !((childViewController?.isKind(of: UIAlertController.self))!)
        return shouldContinueSearch ? childViewController!.findContentViewControllerRecursively() : self
    }
    
    func loadNibFile(_ name: String, owner: Any?, options: [AnyHashable: Any]? = nil) -> Void {
        Bundle.main.loadNibNamed(name, owner: owner, options: options as? [UINib.OptionsKey : Any])
    }
    
    func popToViewController(_ controllerType: UIViewController.Type, modelObj: AnyObject? = nil) -> UIViewController? {
        for control in self.navigationController!.viewControllers as Array {
            if control.isKind(of: controllerType) {
                self.navigationController!.popToViewController(control, animated: true)
                return control
            }
        }
        return nil
    }
    
    func popOrDismissViewController(_ animated: Bool) {
        if self.isPresentedModally() {
            self.dismiss(animated: animated, completion: nil)
        } else if self.navigationController != nil {
            _ = self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func presentAlertController(title:String, message:String, buttons:[String]){
      UIApplication.visibleViewController.present(UIAlertController.alert(title, message: message, buttons: buttons, completion: nil), animated: true, completion: nil)
        
    }
    
    func controllerWithActions(title: String, message: String, buttons: [String] = ["Ok"], completion: ((_ success: Bool) -> Void)?)  {
        UIApplication.visibleViewController.present(UIAlertController.alert(title, message: message, buttons: buttons) { (Alert, value) in
            if value == 1 {
                completion!(true)
            }
        }, animated: true, completion: nil)
    }
    
    
    /**
     It sets a **custom Navigation View** on the screen.
     - Author:  Tushar Sharma
     - Returns: Void
     - Parameters:
     - barType : Type of Screen
     */
    func customNavigationView(barType: appeculesScreen){
        let view = NavigationBar.loadFromNib() as! NavigationBar
        view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: 74)
        UIApplication.visibleViewController.navigationController?.navigationBar.isHidden = true
        view.barType = barType
        UIApplication.visibleViewController.view.addSubview(view)
    }
    
    @objc func backButton(_ sender: UIButton){
        self.popOrDismissViewController(true)
    }
    
    /**
     It navigates to the provided View Controller type .
     - Author:  Tushar Sharma
     - Returns: Void
     - Parameters:
     - newControl : Name of View Controller to which you want to Navigate
     - StoryBoard : Name of storyBoard in which View Controller consist which you want to Navigate
     */
    func navigate(newControl: viewControllers,StoryBoard:String){
        let viewControllerNameIs : String = getAppeculesViewController(VC: newControl)
        let storyBoard : UIStoryboard = UIStoryboard(name: StoryBoard, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: viewControllerNameIs)
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func getAppeculesViewController(VC: viewControllers) -> String{
        switch VC {
        default:
            print("PresentVC",VC)
        }
        return VC.rawValue
    }
    
    func registerTableCell(tableView: UITableView, tableViewCell: String) {
        let userDataCell = UINib(nibName: tableViewCell, bundle: nil)
        tableView.tableFooterView = UIView()
        tableView.register(userDataCell, forCellReuseIdentifier: tableViewCell)
    }
    
    func saveWithCoreData(entityName: String, Entries: [String: String]){
        print(Entries.keys.count)
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: entityName,
                                       in: managedContext)!
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        for (key, value) in Entries { 
             person.setValue(value, forKeyPath: key)
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    /*
    func customAddChildViewController(_ child: UIViewController) {
        self.customAddChildViewController(child, toSubview: self.view)
    }
    
    func customAddChildViewController(_ child: UIViewController, toSubview subview: UIView) {
        self.addChild(child)
        subview.addSubview(child.view)
        child.view.addConstraintToFillSuperview()
        child.didMove(toParent: self)
    }
    
    func customRemoveFromParentViewController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func customRemoveAllChildViewControllers() {
        for control: UIViewController in self.children {
            control.customRemoveFromParentViewController()
        }
    }
    
    func popOrDismissViewController(_ animated: Bool) {
        if self.isPresentedModally() {
            self.dismiss(animated: animated, completion: nil)
        } else if self.navigationController != nil {
            _ = self.navigationController?.popViewController(animated: animated)
        }
    }*/
}

//
//enum appeculesScreen: String {
//    case home = "Home", orderHistory = "My Orders"
//    //return the value of the object
//    var value: String {
//        return self.rawValue
//    }
//}
