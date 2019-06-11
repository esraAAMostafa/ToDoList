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
    var currentUser: User?

    @IBAction func loginIsPressed(_ sender: UIButton) {
        login(userNameText.text)
    }
    
    func login(_ userName: String?) {
        if let name = userName, userName != "" {
            currentUser = User.getUser(name)
            segue("ToListToDo")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToListToDo" {
            if let nextVc = segue.destination as? TodoListview {
                nextVc.currentUser = currentUser
            }
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        userNameText.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
