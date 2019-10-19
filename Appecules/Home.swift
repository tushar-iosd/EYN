//
//  ViewController.swift
//  Appecules
//
//  Created by admin on 27/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import EasyTipView
class Home: UIViewController {
    
    var easyTipHelper = EasyTipViewHelper()
    
    @IBOutlet weak var asa: UIButton!
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        print("EasyTipViewDismissed")
    }
    
    var tipView : EasyTipView?
    @IBOutlet weak var nextScreenButton: UIButton!
      @IBOutlet weak var showAlertBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       // showOutgoingMessage(width: 280, height: 50)
        self.customNavigationView(barType:appeculesScreen.Home)
        easyTipHelper.setPreferences()
         // Do any additional setup after loading the view.
    }
    
 

    @IBAction func showAnAlert(_ sender: Any) {
        // Single Alert Action
      //   self.presentAlertController(title: "Appecules", message: "A Sample Message", buttons: ["Okay"])
        
        //Multiple Action Alert
        UIAlertController.showAlert(ApplicationHeaders.appName, message: ApplicationHeaders.appName, buttons: [AppAlertMessage.okay, AppAlertMessage.cancel,AppAlertMessage.no]) { (alert, index) in
            if index == 0 {
            } else if index == 1 {
            }
            else if index == 2{
                print("222")
            }
        }
    }
    

    @IBAction func navigateToNextScreen(_ sender: Any) {
       // Navigating to UserData Screen
        navigate(newControl: viewControllers.UserData, StoryBoard: storyBoardID.Main.rawValue)
    }
    
    //Easy Tip View Display
    func easyTip(){
        /*
         var preferences = EasyTipView.Preferences()
         preferences.drawing.font = UIFont(name: "Futura-Medium", size: 13)!
         preferences.drawing.foregroundColor = UIColor.darkGray
         preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
         preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.bottom
         preferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
         preferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: -15)
         tipView = EasyTipView(text: "Some textsadasfadSFMLAMSDLFJOADJSFOJADSJFJADSFJADSJFASDJLJFJKLASDNJKFKADSFJKLADSKLFNADSFJKLAJKSDHFKADHSFKHADJKSFHOADSHFHASFADSHFJKLAHSDJKLFHAJKLSDHFKLJDHSFJKLHASDJKLFHAJSDFJKLAHSDJKFHJKLADSHFJKLAHSDKLJFHNASJKLDFJKLADSHFKJAHSDFJKLHASDKHFJKLASDHFJKHASDKHFJKLASEHIO", preferences: preferences)*/
        tipView  = EasyTipView(text: "Some textsadasfadSFMLAMSDLFJOADJSFOJADSJFJADSFJADSJFASDJLJFJKLASDNJKFKADSFJKLADSKLFNADSFJKLAJKSDHFKADHSFKHADJKSFHOADSHFHASFADSHFJKLAHSDJKLFHAJKLSDHFKLJDHSFJKLHASDJKLFHAJSDFJKLAHSDJKFHJKLADSHFJKLAHSDKLJFHNASJKLDFJKLADSHFKJAHSDFJKLHASDKHFJKLASDHFJKHASDKHFJKLASEHIO", preferences: easyTipHelper.globalPreferences)
        tipView?.show(forView: self.nextScreenButton, withinSuperview: self.view)
        //  tipView?.preferences.animating.showFinalTransform =  Animating.dis
        
        /*
         EasyTipView.show(forView: self.nextScreenButton,
         withinSuperview: self.navigationController?.view,
         text: "Tip view inside the navigation controller's view. Tap to dismiss!",
         preferences: preferences,
         delegate: self)*/
    }
}

//UserDataVC

extension Home {
    
    /*
     Closure Example
    1. Closures are self-contained blocks of functionality that can be passed around and used in your code.
     -> Closures can capture and store references to any constants and variables from the context in which they are defined, known as closing over hence Closure.
     
     () Doesn’t have a name of its own.
     () Can captures any values from its environment.
     
     */
    //A MEthod which will create a Closue on a function
    func closureMethod(completion: (String) -> ()){
        let stringToCapture : String = "a"
        completion(stringToCapture)
    }
    // A function will execute closure
    func executeClosure(){
        closureMethod(completion: { (String) -> Void in
            print("Completion code executed",String)
            
        })
    }
}
