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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        groupImage.setCornerRadius(radius: Float(groupImage.frame.height)/2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureWithConnectionData(data: GroupModel) {
        self.groupName.text = data.name_of_group ?? ""
        
        if let urlString = data.image {
            self.groupImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        
    }
    
}
