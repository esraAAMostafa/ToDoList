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
        doneButton.imageView?.image = task.doneState ? #imageLiteral(resourceName: "ic-done") : #imageLiteral(resourceName: "ic-not-done")
        taskTitleButton.titleLabel?.text = task.title
        taskDateText.text = formateDate(task.date, "MMM d yyyy")
        setPriority(task.priorityLevel)
    }
    
    func setPriority(_ prioirty: Int) {
        priorityLevelsButtons.forEach { button  in
            button.layer.borderWidth = 1
            button.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)

            if button.tag == prioirty {
                button.backgroundColor =  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            } else {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitleColor(#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), for: .normal)
            }
        }
    }
}
