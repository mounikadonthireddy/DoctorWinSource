//
//  ProfileImageCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 10/02/22.
//

import UIKit

class ProfileImageCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var saveBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        saveBtn.setCornerRadius(radius: Float(saveBtn.frame.height)/2)
        profileImage.setCornerRadiusWithBorderColor(radius:  Float(profileImage.frame.height)/2 ,color: UIColor.lightGray, borderWidth: 0.4)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        
    }
    @IBAction func addImageClicked(_ sender: UIButton) {
        
    }
    func cellConfigureWith(data: ProfileDataModel) {
        if let urlString = data.image {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            
            self.profileImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if let urlString1 = data.cover_image {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString1
            
            self.coverImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    
}
