//
//  MainHelper.swift
//  TodoList
//
//  Created by Esraa on 6/10/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

extension UIViewController {
    func segue(_ id: String) {
        self.performSegue(withIdentifier: id, sender: self)
    }
}

extension NSObject {
    func formateDate(_ date: Date, _ format: String) -> String {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = format
        return dateFormate.string(from: date)
    }
}
