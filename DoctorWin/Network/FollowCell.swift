//
//  FollowCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 03/01/22.
//

import UIKit

class FollowCell: UITableViewCell {
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        followBtn.setCornerRadius(radius: 5)
        personImage.setCornerRadius(radius: Float(personImage.frame.width)/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfigureWithFollowData(data: FollowModel) {
        self.name.text = data.name ?? ""
        self.nameType.text = data.speciality ?? ""
        if let urlString = data.image {
         self.personImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}

struct FollowModel: Codable {
    let posted_id: String?
    let speciality: String?
    let name: String?
    let image: String?
}
struct FollowResponse: Codable {
    let message: String?
    let userDetails: [FollowModel]?
}
