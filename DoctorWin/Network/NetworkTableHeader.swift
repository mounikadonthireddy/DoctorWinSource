//
//  NetworkTableHeader.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/04/22.
//

import UIKit

class NetworkTableHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var requestBtn: UIButton!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rt: CGRect) {
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
