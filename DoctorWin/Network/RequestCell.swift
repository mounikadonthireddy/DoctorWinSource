//
//  RequestCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 06/05/22.
//

import UIKit

class RequestCell: UITableViewCell {

    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var qualification: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.personImage.setCornerRadius(radius: Float(personImage.frame.width)/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfigureWithConnectionData(data: NotificationModel) {
        self.name.text = (data.name ?? "") + (data.speciality ?? "" ) + ", started following you"
//        self.qualification.text = (data.hightest_qualification ?? "" ) + ", started following you"
        if let urlString = data.image {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
