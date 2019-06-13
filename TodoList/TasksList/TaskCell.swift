//
//  TaskCell.swift
//  TodoList
//
//  Created by Esraa on 6/10/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var taskTitleButton: UIButton!
    @IBOutlet weak var taskDateText: UILabel!
    @IBOutlet var priorityLevelsButtons: [UIButton]!

    func configure(_ task: Task) {
        doneButton.setImage( task.doneState ? #imageLiteral(resourceName: "ic-done") : #imageLiteral(resourceName: "ic-not-done"), for: .normal)
        taskTitleButton.setTitle(task.title, for: .normal)
        taskDateText.text = formateDate(task.date, "MMM d yyyy")
        MainHelper.setPriority(task.priorityLevel, for: priorityLevelsButtons)
    }
}
