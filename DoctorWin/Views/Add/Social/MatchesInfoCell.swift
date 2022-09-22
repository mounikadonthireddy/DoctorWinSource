//
//  MatchesInfoCell.swift
//  DoctorWin
//
//  Created by AHP on 22/09/2565 BE.
//

import UIKit

class MatchesInfoCell: UICollectionViewCell {
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(data: ProfileCharModel) {
        categoryName.text = data.value ?? ""
        if let image = data.image {
            self.categoryImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "loginBg"))
            
        }
    }
    
}
