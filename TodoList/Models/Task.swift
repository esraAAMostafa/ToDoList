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
    
    static func filterByDone(_ currenUser: User) -> [Task] {
        return currenUser.tasksList.filter({$0.doneState})
    }
    
    func setDoneState() {
        DatabaseManager.sharedInstance.editToDone(self)
    }
    
    func setPriorityLevel(_ level: Int) {
        DatabaseManager.sharedInstance.editPriority(self, level)
    }
}
