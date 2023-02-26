//
//  AdminGroupCell.swift
//  DoctorWin
//
//  Created by AHP on 26/02/2566 BE.
//

import UIKit

class AdminGroupCell: UICollectionViewCell {
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var headerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        groupImage.setCornerRadius(radius: Float(groupImage.frame.height)/2)
        headerView.setCornerRadius(radius: Float(headerView.frame.height)/2)
    }
    func configureWithConnectionData(data: AdminGroupModel) {
        self.groupName.text = data.name ?? ""
        if data.admin_status == true {
            
        }
        if let urlString = data.image {
            self.groupImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        
    }
}
