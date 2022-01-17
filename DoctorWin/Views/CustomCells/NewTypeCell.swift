//
//  NewTypeCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 03/01/22.
//

import UIKit

class NewTypeCell: UICollectionViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    //@IBOutlet weak var newsTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.setCornerRadius(radius: Float(newsImage.frame.size.width)/2)
        // Initialization code
    }

}
