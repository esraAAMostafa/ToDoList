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
        print(userNameText.text ?? "")
    }
}

