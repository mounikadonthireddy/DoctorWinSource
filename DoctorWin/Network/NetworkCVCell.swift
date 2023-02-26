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
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var qualification: UILabel!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.personImage.setCornerRadius(radius: 25)
    }
    func cellConfigureWithGroupData(data: GroupModel) {
        self.name.text = data.name ?? ""
        let follow  = "\(data.total_joined ?? 0) " + "Followers,"
        self.qualification.text =  follow + (data.description ?? "")
        self.setImagesforItems(profileImg: data.image)
    }
    func cellConfigureWithPeopleData(data: PeopleModel) {
        self.name.text = data.name ?? ""
        self.qualification.text = data.speciality ?? ""
        self.setImagesforItems(profileImg: data.image)
    }
    func setImagesforItems(profileImg: String?) {
        if let urlString = profileImg {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
