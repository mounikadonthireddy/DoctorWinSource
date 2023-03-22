//
//  AppointmentCell.swift
//  DoctorWin
//
//  Created by AHP on 22/03/2566 BE.
//

import UIKit

class AppointmentCell: UITableViewCell {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var addressTF: UITextView!
    @IBOutlet weak var messageTF: UITextView!
    @IBOutlet weak var bookBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
