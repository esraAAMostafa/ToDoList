//
//  AddTaskView.swift
//  TodoList
//
//  Created by Esraa on 6/10/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

protocol AddTaskDelegate: class {
    func createTask(_ title: String?)
    func dismissAddTaskPopup()
}

class AddTaskView: UIViewController {

    @IBOutlet weak var taskTitleText: UITextField!
    @IBOutlet weak var backGroundView: UIView!
    weak var delegate: AddTaskDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        backGroundView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(dismissPopup)))
    }

    @IBAction func createIsPressed(_ sender: UIButton) {
        delegate.createTask(taskTitleText.text)
    }
    
    @objc func dismissPopup() {
        delegate.dismissAddTaskPopup()
    }
}
