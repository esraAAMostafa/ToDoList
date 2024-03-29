//
//  TaskDetailsView.swift
//  TodoList
//
//  Created by Esraa on 6/10/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit
import RealmSwift

class TaskDetailsView: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var doneStateButton: UIButton!
    @IBOutlet weak var TaskDateLabel: UILabel!
    @IBOutlet var priorityLevelButtons: [UIButton]!

    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var commentsTableView: UITableView!
    
    var currentTask: Task!
    var comments: [Comment]!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    func initView() {
        comments = Array(currentTask.comments)
        commentsTableView.reloadData()

        taskTitle.text = currentTask.title
        doneStateButton.setImage(currentTask.doneState ? #imageLiteral(resourceName: "ic-done") : #imageLiteral(resourceName: "ic-not-done"), for: .normal)
        TaskDateLabel.text = formateDate(currentTask.date, "MMM d yyyy")
        MainHelper.setPriority(currentTask.priorityLevel, for: priorityLevelButtons)
    }
    
    @IBAction func setDoneStateIsPressed(_ sender: UIButton) {
        currentTask.setDoneState()
        initView()
    }
    
    @IBAction func priorityButtonsIsPressed(_ sender: UIButton) {
        currentTask.setPriorityLevel(sender.tag)
        initView()
    }

    @IBAction func addCommentIsPressed(_ sender: UIButton) {
        addComment(commentTF.text)
        commentTF.text = ""
    }

    func addComment(_ text: String?) {
        if let text = text, text != "" {
            currentTask.addComment(text)
            initView()
        }
    }
    
    @IBAction func deleteIsPressed(_ sender: UIButton) {
        currentTask.delete()
        self.dismiss(animated: true)
    }
    
    @IBAction func backIsPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension TaskDetailsView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell {
            if let comment = comments?[indexPath.row] {
                cell.configure(comment)
                return cell
            }
        }
        return UITableViewCell()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
