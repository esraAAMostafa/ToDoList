//
//  TodoListview.swift
//  TodoList
//
//  Created by Esraa on 6/10/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class TodoListview: UIViewController {

    @IBOutlet weak var filterIcon: UIImageView!
    @IBOutlet weak var filterTitle: UILabel!
    @IBOutlet weak var userListTitle: UILabel!
    @IBOutlet weak var addTaskPopUpView: UIView!
    
    var currentUser: User!
    var currentTask: Task!
    var isFiltered = false
    var tasks: [Task]!
    var tasksView: TasksView!

    override func viewWillAppear(_ animated: Bool) {
        initView()
    }

    private func initView() {
        tasks = currentUser.tasksList
        userListTitle.text = "\(currentUser.name)'s Tasks"
        tasksView.reloadData()
    }

    @IBAction func backIsPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

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
        
        if segue.identifier == "Tasks" {
            if let nextVC = segue.destination as? TasksView {
                tasksView = nextVC
                nextVC.delegate = self
                nextVC.toDoListView = self
            }
        }
    }
}

extension TodoListview: AddTaskDelegate {

    @IBAction func addTaskIsPressed(_ sender: UIButton) {
        addTaskPopUpView.isHidden = false
    }

    func createTask(_ title: String?) {
        if let title = title, title != "" {
            currentUser.addTask(title)
            dismissAddTaskPopup()
            initView()
        }
    }

    func dismissAddTaskPopup() {
        addTaskPopUpView.isHidden = true
    }
}

extension TodoListview: TasksViewDelegate {
    func setDoneState(indexPath: IndexPath) {
        currentUser.tasksList[indexPath.row].setDoneState()
    }
    
    func openTask(indexPath: IndexPath) {
        currentTask = currentUser.tasksList[indexPath.row]
        segue("ToTaskDetails")
        
    }
    
    func setPriorityLevel(indexPath: IndexPath, tag: Int) {
        currentUser.tasksList[indexPath.row].setPriorityLevel(tag)
    }
}

extension TodoListview {

    @IBAction func filterIsPressed(_ sender: UIButton) {
        isFiltered ? noFilterWithDone() : filterWithDone()
        tasksView.reloadData()
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
        showAllTasks()
    }
    
    func showDoneTasks() {
        tasks = currentUser.filterByDoneTasks()
    }
    
    func showAllTasks() {
        tasks = currentUser.tasksList
    }
}
