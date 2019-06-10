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

    func add(object: Object) {
        do {
            try database?.write {
                database?.add(object, update: false)
                print("Added new Item")
            }
        } catch {
            print("Fail to add Item")
        }
    }
    
    func update(object: Object) {
        do {
            try database?.write {
                database?.add(object, update: true)
                print("Added new Item")
            }
        } catch {
            print("Fail to add Item")
        }
    }
    
    func getData(type: Object.Type) -> Results<Object> {
        let results = database!.objects(type)
        return results
    }

    
    func getUsers() -> Results<User> {
        let results = database!.objects(User.self)
        return results
    }
    
    func getTasks() -> Results<Task> {
        let results = database!.objects(Task.self)
        return results
    }
    
    func getComments() -> Results<Comment> {
        let results = database!.objects(Comment.self)
        return results
    }
    
    func delete(object: Object) {
        do {
            try database?.write {
                database?.delete(object)
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
