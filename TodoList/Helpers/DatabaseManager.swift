//
//  DatabaseManager.swift
//  TodoList
//
//  Created by Esraa on 6/8/19.
//  Copyright © 2019 example. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {

    private var database: Realm?
    static let sharedInstance = DatabaseManager()

    private init() {
        do {
            database = try Realm()
        }
        catch {
            print("Fail to initialize realm")
        }
    }
    
    func getUsers() -> Results<User> {
        let results = database!.objects(User.self)
        return results
    }

    func getTasks() -> Results<Task> {
        let results = database!.objects(Task.self)
        return results
    }

    func add<T>(object: T) {
        do {
            try database?.write {
                database?.add(object as! Object, update: true)
                print("Added new Item")
            }
        } catch {
            print("Fail to add Item")
        }
    }

    func delete<T>(object: T) {
        do {
            try database?.write {
                database?.delete(object as! Object)
            }
        } catch {
            print("Fail to delete Item")
        }
    }
    
    func deleteAll() {
        do {
            try database?.write {
                database?.deleteAll()
            }
        } catch {
            print("Fail to delete All Items")
        }
    }
}
