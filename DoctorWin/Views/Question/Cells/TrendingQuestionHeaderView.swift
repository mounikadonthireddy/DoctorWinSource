//
//  TrendingQuestionHeaderView.swift
//  DoctorWin
//
//  Created by AHP on 14/09/2565 BE.
//

import UIKit

class TrendingQuestionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var nameLbl: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
