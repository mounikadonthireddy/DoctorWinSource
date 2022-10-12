//
//  ConnectLikeCell.swift
//  DoctorWin
//
//  Created by AHP on 25/09/2565 BE.
//

import UIKit

class ConnectLikeCell: UICollectionViewCell {
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personAge: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        personView.setCornerRadius(radius: 15)
    }

}
