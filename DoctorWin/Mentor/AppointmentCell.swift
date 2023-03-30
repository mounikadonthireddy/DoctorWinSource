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
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.dropShadow()
       // bgView.setCornerRadius(radius: 10)
        addressTF.setCornerRadiusWithBorderColor(radius: 8, color: UIColor.lightGray, borderWidth: 0.5)
        messageTF.setCornerRadiusWithBorderColor(radius: 8, color: UIColor.lightGray, borderWidth: 0.5)
        bookBtn.setCornerRadius(radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
