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
        followBtn.setCornerRadiusWithBorderColor(radius: 15, color: UIColor.blue, borderWidth: 0.5)
        self.personImage.setCornerRadius(radius: 29)
    }

   
    func cellConfigureWithConnectionData(data: NetworkModel) {
        self.name.text = data.ProfileName ?? ""
        self.qualification.text = data.hightest_qualification ?? ""
        self.location.text = data.speciality ?? ""
        if let urlString = data.ProfileImage {
         self.personImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
