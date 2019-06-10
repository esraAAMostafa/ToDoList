//
//  CommentCell.swift
//  TodoList
//
//  Created by Esraa on 6/10/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var commentDate: UILabel!
    
    func configure(_ comment: Comment) {
        commentTextLabel.text = comment.details
        commentDate.text = "\(durationDate(comment.date)) hours ago."
    }
}
