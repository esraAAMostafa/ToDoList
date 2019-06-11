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
    var comments: Results<Comment>!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        comments = DatabaseManager.sharedInstance.getComments()
    }

    func initView() {
        taskTitle.text = currentTask.title
        doneStateButton.imageView?.image = currentTask.doneState ? #imageLiteral(resourceName: "ic-done") : #imageLiteral(resourceName: "ic-not-done")
        TaskDateLabel.text = formateDate(currentTask.date, "MMM d yyyy")
        
        setPriority(currentTask.priorityLevel)
        commentsTableView.reloadData()
    }
    
    func setPriority(_ prioirty: Int) {
        priorityLevelButtons.forEach { button  in
            button.layer.borderWidth = 1
            button.layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            
            if button.tag == prioirty {
                button.backgroundColor =  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            } else {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitleColor(#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), for: .normal)
            }
        }
    }

    @IBAction func backIsPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @IBAction func addCommentIsPressed(_ sender: UIButton) {
        addComment(commentTF.text)
    }

    func addComment(_ text: String?) {
        if let text = title, text != "" {
            let comment = Comment()
            comment.details = text
            DatabaseManager.sharedInstance.addOrUpdate(object: comment)
        }
    }
    
    @IBAction func deleteIsPressed(_ sender: UIButton) {
        DatabaseManager.sharedInstance.delete(object: currentTask)
        self.dismiss(animated: true)
    }

    @IBAction func setDoneStateIsPressed(_ sender: UIButton) {
    }
}

extension TaskDetailsView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell {
            cell.configure(comments[indexPath.row])
            return cell
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
