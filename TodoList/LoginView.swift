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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginIsPressed(_ sender: UIButton) {
        if let userName = userNameText.text, userName != "" {
            let user = User()
            user.Name = userName
            DatabaseManager.sharedInstance.add(object: user)
            print(DatabaseManager.sharedInstance.getData())
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        userNameText.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
