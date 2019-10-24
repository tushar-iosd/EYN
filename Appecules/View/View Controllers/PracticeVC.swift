//
//  PracticeVC.swift
//  Appecules
//
//  Created by admin on 23/10/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class PracticeVC: UIViewController {

    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var outPutLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationView(barType:appeculesScreen.Practice)
        // Do any additional setup after loading the view.
    }

    @IBAction func palindromAction(_ sender: Any) {
      //  palindromWithReversedFunction() //1.
        
    /*    if (palindromBySwapingValues()) {
            outPutLabel.backgroundColor = .green
            outPutLabel.text = "It's Palindrom"
        } else {
            outPutLabel.backgroundColor = .red
            outPutLabel.text = "It's Not Palindrom"
        }*/ //2.
        
        palindrom()
    }
    
    //Finding palindrom by using Reverse function of String
    func palindromWithReversedFunction(){
        let string : String = inputTF.text ?? "1212"
         let reverseString = String(string.reversed())
        if (reverseString == string) {
             outPutLabel.backgroundColor = .green
            outPutLabel.text = "It's Palindrom"
        } else {
            outPutLabel.backgroundColor = .red
            outPutLabel.text = "It's Not Palindrom"
        }
    }
    
    // Finding Palindrom while checking first and last Element of String
    func palindromBySwapingValues () -> Bool{
         let inputString : String = inputTF.text ?? "1212"
        let count: Int = inputString.count
        for index in 0..<count/2 {
            let index1 = inputString.index(inputString.startIndex, offsetBy: index)
            let firstVar: Character = inputString[index1]
            
             let index2 = inputString.index(inputString.startIndex, offsetBy: count - index - 1)
            let secondVar: Character = inputString[index2]
            if (firstVar != secondVar) {
                
            } else {
               
                return false
            }
        }
         return true
        }
    
    func palindrom () {
        // for (int i=str.length()-1; i>=0; i--)
        let inputString: String = inputTF.text ?? "121"
        
        let count: Int = inputString.count - 1
        
        for index in count ..> 0 {
            let index1 = inputString.index(inputString.startIndex, offsetBy: index)
            let firstVar: Character = inputString[index1]
            print(firstVar)
        }
    }
}
