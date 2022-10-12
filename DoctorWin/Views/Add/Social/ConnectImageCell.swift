//
//  ConnectImageCell.swift
//  DoctorWin
//
//  Created by AHP on 25/09/2565 BE.
//

import UIKit

class ConnectImageCell: UICollectionViewCell {
    @IBOutlet weak var personImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(data: GenderImageModel) {
        if let urlString3 = data.image {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString3), placeholderImage: UIImage(named: "loginBg"))
        }
        
    }

}
