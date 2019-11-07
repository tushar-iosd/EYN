//
//  AddUserCell.swift
//  Appecules
//
//  Created by admin on 21/10/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class AddUserCell: UITableViewCell {

    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var empID: UITextField!
    @IBOutlet weak var technology: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func saveEntry(){
        
    }
    
}
