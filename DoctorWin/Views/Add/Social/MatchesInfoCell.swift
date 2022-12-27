//
//  MatchesInfoCell.swift
//  DoctorWin
//
//  Created by AHP on 22/09/2565 BE.
//

import UIKit

class MatchesInfoCell: UICollectionViewCell {
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setCornerRadius(radius: 10)
        bgView.dropShadow()
    }
    func configureCell(data: ProfileCharModel) {
        categoryName.text = data.value ?? ""
        categoryTitle.text = data.name ?? ""
//        if let image = data.image {
//            self.categoryImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + image), placeholderImage: UIImage(named: "loginBg"))
//
//        }
    }
    
}
