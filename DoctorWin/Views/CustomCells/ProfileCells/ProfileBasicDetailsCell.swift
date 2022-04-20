//
//  ProfileBasicDetailsCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit

class ProfileBasicDetailsCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var emailID: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var professionalEdit: UIButton!
    @IBOutlet weak var basicView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        basicView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE6E6E6), borderWidth: 0.5)
        professionalEdit.setCornerRadius(radius: 15)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfigureWith(data: ProfileDataModel) {
        self.contactNumber.text = data.phoneNumber
        self.emailID.text = data.email
        self.gender.text = data.gender ?? "XXXXXXX"
        self.dob.text = data.dob ?? "XXXXXXX"
    }
    
}
