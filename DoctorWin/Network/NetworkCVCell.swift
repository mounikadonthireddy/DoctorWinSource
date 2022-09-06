//
//  NetworkCVCell.swift
//  DoctorWin
//
//  Created by AHP on 03/09/2565 BE.
//

import UIKit

class NetworkCVCell: UICollectionViewCell {
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var qualification: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        followBtn.setCornerRadiusWithBorderColor(radius: 15, color: UIColor.clear, borderWidth: 0.5)
        self.personImage.setCornerRadius(radius: 29)
        bgView.setCornerRadiusWithBorderColor(radius: 8, color: UIColor.lightGray, borderWidth: 0.5)
    }

   
  
    func cellConfigureWithGroupData(data: GroupModel) {
        self.name.text = data.name_of_group ?? ""
        self.qualification.text = data.description ?? ""
        self.location.text = "\(data.number_of_joined ?? 0) " + "Followers"
        self.setImagesforItems(profileImg: data.image, bgImage: data.cover_image)
        followBtn.setTitle("Join", for: .normal)
    }
    func cellConfigureWithPeopleData(data: PeopleModel) {
        self.name.text = data.ProfileName ?? ""
        self.qualification.text = data.hightest_qualification ?? ""
        self.location.text = data.speciality ?? ""
        self.setImagesforItems(profileImg: data.ProfileImage, bgImage: data.cover_image)
        followBtn.setTitle("Follow", for: .normal)
    }
    func setImagesforItems(profileImg: String?, bgImage: String?) {
        if let urlString = profileImg {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if let urlString = bgImage {
            self.bgImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
