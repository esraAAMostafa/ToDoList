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
    
    static func addUser(_ userName: String) -> User {
        let user = User()
        user.name = userName
        DatabaseManager.sharedInstance.addOrUpdate(object: user)
        return user
    }
}
