//
//  AddCasesTitleHeader.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 15/02/22.
//

import UIKit

class AddCasesTitleHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var titleImage: UIImageView!

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
