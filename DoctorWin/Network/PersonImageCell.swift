//
//  PersonImageCell.swift
//  DoctorWin
//
//  Created by AHP on 13/09/2565 BE.
//

import UIKit

class PersonImageCell: UICollectionViewCell {
    @IBOutlet weak var personImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        personImage.setCornerRadius(radius: Float(personImage.frame.height)/2)
        // Initialization code
    }
    func configure(data: GenderImageModel) {
        if let image = data.image {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + image), placeholderImage: UIImage(named: "loginBg"))
        }
    }

}
