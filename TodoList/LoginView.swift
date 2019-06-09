//
//  ViewController.swift
//  TodoList
//
//  Created by Esraa on 6/1/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class LoginView: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameText: UITextField!

    @IBAction func loginIsPressed(_ sender: UIButton) {
        login(userNameText.text)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        userNameText.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func login(_ userName: String?) { // return user data
        if let name = userName, userName != "" {
            let user = User()
            user.name = name
            DatabaseManager.sharedInstance.add(object: user)
            print(DatabaseManager.sharedInstance.getData())
//            return userdata
        }
    }
}
