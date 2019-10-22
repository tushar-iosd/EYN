//
//  Constant.swift
//  Appecules
//
//  Created by admin on 27/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit

enum storyBoardID: String {
    case Main = "Main"
}

enum viewControllers: String {
    case Home = "Home"
    case UserData = "UserDataVC"
    case AddUser = "AddUserVC"
    case UserDetails = "UserDetailVC"
    //case Profile = "ProfileVC"
}

enum AppAlertMessage {
      static let dataSaved = "Data Saved"
    static let okay = "Okay"
    static let cancel = "Cancel"
    static let no = "No"
    static let nameBlank = "Entry cannot be blank"
}
enum ApplicationHeaders {
    static let appName = "Appecules"
}
