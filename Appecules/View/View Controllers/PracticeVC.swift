//
//  PracticeVC.swift
//  Appecules
//
//  Created by admin on 23/10/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

enum AlgoNames: String {
    case Palindrom
    case Reverse
}
private var algoTypes = AlgoNames.Palindrom

class PracticeVC: UIViewController {
  
    @IBOutlet weak var algoDetailView: UIView!
    @IBOutlet weak var algoDetailScrollView: UIScrollView!
    @IBOutlet weak var algoDetailControlView: UIView!
    
    @IBOutlet weak var selectedAlgoLabel: UILabel!
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var outPutLabel: UILabel!
    var algoTypePicker : UIPickerView!
     var algoTypePickerValue = ["dd"]
    var toolBar = UIToolbar()
    var selectedAlgo = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         self.customNavigationView(barType:AppeculesScreen.Practice)
        algoTypePicker = UIPickerView()
        
    /*    algoTypePicker.dataSource = self
        algoTypePicker.delegate = self*/
     
    }
    @IBAction func iAlgoDetailButtonAction(_ sender: Any) {
    }
    @IBAction func executeBtnAction(_ sender: Any) {
        let executableAlgo =  algoValue(rawValue: selectedAlgo)
       
        switch executableAlgo {
        case .swappingValues?:
            if palindromBySwapingValues() {
                outPutLabel.backgroundColor = .green
                outPutLabel.text = "It's Palindrom"
            } else {
                outPutLabel.backgroundColor = .red
                outPutLabel.text = "It's Not Palindrom"
            }
        case .reversedFunction?:
            self.palindromWithReversedFunction()
        case .reversingString?:
            if palindromByReversingString() {
                outPutLabel.backgroundColor = .green
                outPutLabel.text = "It's Palindrom"
            } else {
                outPutLabel.backgroundColor = .red
                outPutLabel.text = "It's Not Palindrom"
            }
        default:
            print("default print")
        }
        
    }
    
    @IBAction func palindromAction(_ sender: Any) {
        algoTypes = .Palindrom
        
   /*    */
   /*     inputTF.inputView = algoTypePicker
        inputTF.text = algoTypePickerValue[0]*/
       displayTypes()
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

    func displayTypes() {
        
        switch algoTypes {
        case .Palindrom:
          algoTypePickerValue = [algoValue.swappingValues.rawValue,algoValue.reversingString.rawValue,algoValue.reversedFunction.rawValue]
        case .Reverse:
            algoTypePickerValue = ["Reverse the String"]
        }
          displayPickerView()
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
                print("1")
                  return false
            } else {
                print("2")
                return true
            }
        }
         print("3")
         return false
        }
    // Finding Palindrom by Reversing a String
    func palindromByReversingString() -> Bool {
        let inputString: String = inputTF.text ?? "121"
        if inputString != "" {
        let count: Int = inputString.count - 1
         var text : String = ""
        for index in (0...count).reversed() {
            
            let index1 = inputString.index(inputString.startIndex, offsetBy: index)
            let firstVar: Character = inputString[index1]
            let stra: String = String(firstVar)
           
            if text.isEmpty {
                text = stra
            } else {
                text += "\(stra)"
            }
        }
        print(text)
        if text == inputString {
            return true
        } else {
           return false
        }
             }
        return false
    }
    func displayPickerView() {
        algoTypePicker = UIPickerView.init()
         algoTypePicker.dataSource = self
        algoTypePicker.delegate = self
        algoTypePicker.backgroundColor = UIColor.white
        algoTypePicker.setValue(UIColor.black, forKey: "textColor")
        algoTypePicker.autoresizingMask = .flexibleWidth
        algoTypePicker.contentMode = .center
        algoTypePicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(algoTypePicker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
          toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
    toolBar.removeFromSuperview()
    algoTypePicker.removeFromSuperview()
    }
 
}
// UIPickerView -  Protocol Stubs / Delegates
extension PracticeVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return algoTypePickerValue.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return algoTypePickerValue[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        selectedAlgo = algoTypePickerValue[row]
        selectedAlgoLabel.text = algoTypes.rawValue + " - " + selectedAlgo
        self.view.endEditing(true)
    }
}
