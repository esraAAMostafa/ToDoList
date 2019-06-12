//
//  User.swift
//  TodoList
//
//  Created by Esraa on 6/8/19.
//  Copyright © 2019 example. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name = ""
    var tasks = List<Task>()

    override static func primaryKey() -> String? {
        return "name"
    }
    
    static func getUser(_ userName: String) -> User {
        let users = DatabaseManager.sharedInstance.getUsers()
        guard let currentUser = users.filter({ $0.name == userName }).first else {
            let user = User()
            user.name = userName
            DatabaseManager.sharedInstance.add(object: user)
            return user
        }
        return currentUser
    }
    
    func addTask(_ title: String) {
        let task = Task()
        task.title = title
        DatabaseManager.sharedInstance.append(task: task, to: tasks)
    }
    
    var tasksList: [Task] {
         return Array(tasks)
    } 
}
