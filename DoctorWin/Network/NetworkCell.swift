//
//  NetworkCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/04/22.
//

import UIKit

class NetworkCell: UITableViewCell {
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var qualification: UILabel!
    @IBOutlet weak var location: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        followBtn.setCornerRadiusWithBorderColor(radius: 15, color: UIColor.blue, borderWidth: 0.5)
        self.personImage.setCornerRadius(radius: 29)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
