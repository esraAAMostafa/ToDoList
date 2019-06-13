//
//  MainHelper.swift
//  TodoList
//
//  Created by Esraa on 6/10/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit

class MainHelper {
    static func setPriority(_ prioirty: Int, for buttons: [UIButton]) {
        buttons.forEach { button  in

            if button.tag == prioirty {
                button.backgroundColor =  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            } else {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.setTitleColor(#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), for: .normal)
            }
        }
    }
}

class RoundedCorener: UIButton {
    @IBInspectable
    var redious: CGFloat = 0 {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = redious
        }
    }
}

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
    
    func durationDate(_ date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: Date()).hour ?? 0
    }
}

extension UIView {
    
    func blurView(_ style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.9
        self.addSubview(blurEffectView)
    }
}
