//
//  Comment.swift
//  TodoList
//
//  Created by Esraa on 6/10/19.
//  Copyright © 2019 example. All rights reserved.
//

import Foundation
import RealmSwift

class Comment: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var details = ""
    @objc dynamic var date = Date()

    override static func primaryKey() -> String? {
        return "id"
    }
}
