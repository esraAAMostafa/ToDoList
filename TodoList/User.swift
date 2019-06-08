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
    @objc dynamic var ID = 0
    @objc dynamic var Name = ""
    override static func primaryKey() -> String? {
        return "Name"
    }
}
