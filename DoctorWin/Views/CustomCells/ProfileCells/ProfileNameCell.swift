//
//  ProfileNameCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit

class ProfileNameCell: UITableViewCell {
    @IBOutlet weak var profileNameView: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var speciality: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        profileNameView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE6E6E6), borderWidth: 0.5)
        profileImage.setCornerRadius(radius: Float(profileImage.frame.width)/2)
        backBtn.setCornerRadius(radius: Float(backBtn.frame.width)/2)
//        editBtn.setCornerRadius(radius: 15)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func cellConfigureWith(data: ProfileDataModel) {
        self.profileName.text = "DR." + (data.profileName ?? "XXXXX")
        self.designation.text = data.speciality ?? "XXXXX"
        self.location.text = data.currentLocation ?? "XXXX"

        self.speciality.text = data.qualification ?? "XXXXX"
        
        if let urlString = data.profileImage {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            
            self.profileImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    
}
