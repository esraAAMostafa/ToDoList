//
//  TasksView.swift
//  TodoList
//
//  Created by Esraa on 6/11/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

protocol TasksViewDelegate: class {
    func setDoneState(indexPath: IndexPath)
    func openTask(indexPath: IndexPath)
    func setPriorityLevel(indexPath: IndexPath, tag: Int)
}

class TasksView: UITableViewController {

    var toDoListView: TodoListview!
    weak var delegate: TasksViewDelegate!

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListView.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell {
            if !toDoListView.tasks.isEmpty {
                cell.configure(toDoListView.tasks[indexPath.row])
                cell.doneButton.addTarget(self, action: #selector(setDoneState(_:)), for: .touchUpInside)
                cell.taskTitleButton.addTarget(self, action: #selector(openTask(_:)), for: .touchUpInside)
                cell.priorityLevelsButtons.forEach { $0.addTarget(self, action: #selector(setPriorityLevel(_:)), for: .touchUpInside)}
                return cell
            }
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    @objc func setDoneState(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        if let indexPath = indexPath {
            self.delegate.setDoneState(indexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    @objc func openTask(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        if let indexPath = indexPath {
            self.delegate.openTask(indexPath: indexPath)
        }
    }
    
    @objc func setPriorityLevel(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        if let indexPath = indexPath {
            self.delegate.setPriorityLevel(indexPath: indexPath, tag: sender.tag)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
