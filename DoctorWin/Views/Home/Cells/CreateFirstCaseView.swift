//
//  CreateFirstCaseView.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 04/01/22.
//

import UIKit

class CreateFirstCaseView: UITableViewHeaderFooterView {

    @IBOutlet weak var postBtn: UIButton!
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
