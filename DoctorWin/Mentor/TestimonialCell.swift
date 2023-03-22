//
//  TestimonialCell.swift
//  DoctorWin
//
//  Created by AHP on 18/03/2566 BE.
//

import UIKit

class TestimonialCell: UICollectionViewCell {
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.lightGray, borderWidth: 0.7)
    }
    
    func configureWith(data: TestimonialModel) {
        messageLbl.text = data.message ?? ""
        if let name = data.name {
            nameLbl.text = "- \(name)"
        }
        if let urlString = data.image {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }

}
