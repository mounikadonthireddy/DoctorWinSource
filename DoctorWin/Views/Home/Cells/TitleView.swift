//
//  TitleView.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 10/01/22.
//

import UIKit

class TitleView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
