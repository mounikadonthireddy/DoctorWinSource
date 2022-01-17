//
//  StoryCell.swift
//  DoctorWin
//
//  Created by N517325 on 26/10/21.
//

import UIKit

class StoryCell: UICollectionViewCell {
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var postedTime: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var personImage: UIImageView!



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.storyImage.clipsToBounds = true
        self.storyImage.layer.cornerRadius = 15
    }

}
