//
//  ServicesCell.swift
//  DoctorWin
//
//  Created by AHP on 18/03/2566 BE.
//

import UIKit

class ServicesCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.lightGray, borderWidth: 0.7)
    }
    func configureCell(data: PlanModel){
        nameLbl.text = data.name
        descriptionLbl.text = data.description
    }
}
