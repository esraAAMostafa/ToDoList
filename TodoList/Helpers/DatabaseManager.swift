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
            }
        } catch {
            print("Fail to add Item")
        }
    }
    
    func update(object: Object) {
        do {
            try database?.write {
                database?.add(object, update: true)
            }
        } catch {
            print("Fail to add Item")
        }
    }
    
    func editToDone( _ task: Task) {
        do {
            try database?.write {
                task.doneState = !task.doneState
                database?.add(task, update: true)
            }
        } catch {
            print("Fail to add Item")
        }
    }

    func editPriority( _ task: Task, _ priority: Int) {
        do {
            try database?.write {
                task.priorityLevel = priority
                database?.add(task, update: true)
            }
        } catch {
            print("Fail to add Item")
        }
    }

    func append(task: Object, to tasks: List<Task>) {
        do {
            try database?.write {
                tasks.append(task as! Task)
                database?.add(tasks, update: true)
            }
        } catch {
            print("Fail to append")
        }
    }
    
    func append(comment: Object, to comments: List<Comment>) {
        do {
            try database?.write {
                comments.append(comment as! Comment)
                database?.add(comments, update: true)
            }
        } catch {
            print("Fail to append")
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
    
    func filterData(_ object: Object.Type, by quary: String) -> Results<Object> {
        let results = database!.objects(object.self).filter(quary)
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
