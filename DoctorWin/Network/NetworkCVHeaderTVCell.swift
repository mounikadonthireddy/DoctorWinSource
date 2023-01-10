//
//  NetworkCVHeaderTVCell.swift
//  DoctorWin
//
//  Created by AHP on 03/09/2565 BE.
//

import UIKit

class NetworkCVHeaderTVCell: UITableViewCell {
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var headerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        groupImage.setCornerRadius(radius: Float(groupImage.frame.height)/2)
        headerView.setCornerRadius(radius: Float(headerView.frame.height)/2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
