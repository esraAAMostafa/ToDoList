//
//  TodoListview.swift
//  TodoList
//
//  Created by Esraa on 6/10/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class TodoListview: UIViewController {
    
    var currentUser: User!
    var currentTask: Task!
    @IBOutlet weak var filterIcon: UIImageView!
    @IBOutlet weak var filterTitle: UILabel!
    @IBOutlet weak var userListTitle: UILabel!
    @IBOutlet weak var addTaskPopUpView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var isFiltered = false
    let task = Task()
    var tasks: [Task]?
    var addTaskView = AddTaskView()
    var selectedTask: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    func initView() {
        userListTitle.text = "\(currentUser.name)'s Tasks"
        tasks = [task, task, task, task]
        tableView.reloadData()
    }

    @IBAction func backIsPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @IBAction func filterIsPressed(_ sender: UIButton) {
        isFiltered ? noFilterWithDone() : filterWithDone()
    }

    @IBAction func addTaskIsPressed(_ sender: UIButton) {
        addTaskPopUpView.isHidden = false
    }
    
    func filterWithDone() {
        isFiltered = true
        filterIcon.image = #imageLiteral(resourceName: "ic-filtered")
        filterTitle.textColor = #colorLiteral(red: 0.2976242006, green: 0.6489446163, blue: 0.9290004373, alpha: 1)
        showDoneTasks()
    }
    
    func noFilterWithDone() {
        isFiltered = false
        filterIcon.image = #imageLiteral(resourceName: "ic-not-filterd")
        filterTitle.textColor = #colorLiteral(red: 0.5019147396, green: 0.5019903183, blue: 0.5018982291, alpha: 1)
    }
    
    func showDoneTasks() {
        print("hay i'm done")
    }
}

extension TodoListview: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell {
            selectedTask = tasks?[indexPath.row] ?? Task()
            cell.configure(tasks?[indexPath.row] ?? Task())
            cell.doneButton.addTarget(self, action: #selector(setDoneState(_:)), for: .touchUpInside)
            cell.taskTitleButton.addTarget(self, action: #selector(openTask(_:)), for: .touchUpInside)
            cell.priorityLevelsButtons.forEach { $0.addTarget(self, action: #selector(setPriorityLevel(_:)), for: .touchUpInside)}
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension TodoListview {
    @objc func setDoneState(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        if let indexPath = indexPath {
            tasks?[indexPath.row].doneState = !tasks![indexPath.row].doneState
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        //update done state in this task
    }
    
    @objc func openTask(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        if let indexPath = indexPath {
            currentTask = tasks?[indexPath.row]
            segue("ToTaskDetails")
        }
    }
    
    @objc func setPriorityLevel(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        if let indexPath = indexPath {
            print("setPriorityLevel")
            tasks?[indexPath.row].priorityLevel = sender.tag
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}

extension TodoListview: AddTaskDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTask" {
            if let nextVC = segue.destination as? AddTaskView {
                nextVC.delegate = self
            }
        }

        if segue.identifier == "ToTaskDetails" {
            if let nextVC = segue.destination as? TaskDetailsView {
                nextVC.currentTask = currentTask
            }
        }
    }

    func createTask(_ title: String?) {
        addTask(title: title)
        dismissAddTaskPopup()
    }
    
    func addTask(title: String?) {
        if let title = title, title != "" {
            let task = Task()
            task.id = currentUser.id
            task.title = title
            DatabaseManager.sharedInstance.add(object: task)
        }
    }

    func dismissAddTaskPopup() {
        addTaskPopUpView.isHidden = true
        print(DatabaseManager.sharedInstance.getTasks())
    }
}
