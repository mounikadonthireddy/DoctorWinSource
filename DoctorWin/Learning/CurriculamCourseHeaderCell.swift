//
//  CurriculamCourseHeaderCell.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import UIKit

class CurriculamCourseHeaderCell: UITableViewHeaderFooterView {

    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var expand: UIButton!
   
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
