//
//  NetworkCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/04/22.
//

import UIKit

class NetworkCell: UITableViewCell {
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var qualification: UILabel!
    @IBOutlet weak var location: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        followBtn.setCornerRadiusWithBorderColor(radius: 15, color: UIColor.blue, borderWidth: 0.5)
        self.personImage.setCornerRadius(radius: 29)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
