//
//  Task.swift
//  TodoList
//
//  Created by Esraa on 6/10/19.
//  Copyright © 2019 example. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var doneState = false
    @objc dynamic var date = Date()
    @objc dynamic var priorityLevel = 0
    var comments = List<Comment>()

    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func addTask(_ title: String, _ doneState: Bool, _ date: Date, _ priorityLevel: Int, to currentUser: User) {
        let task = Task()
        task.title = title
        task.doneState = doneState
        task.date = date
        task.priorityLevel = priorityLevel
        currentUser.tasks.append(task)
        DatabaseManager.sharedInstance.addOrUpdate(object: currentUser)
    }
}
