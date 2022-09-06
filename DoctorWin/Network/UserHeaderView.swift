//
//  UserHeaderView.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/05/22.
//

import UIKit

class UserHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var specialityLbl: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var personsCV: UICollectionView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: [ "Post","Cases", "Questions", "Answers"])
            interfaceSegmented.selectorViewColor = .blue
            interfaceSegmented.selectorTextColor = .blue
            //interfaceSegmented.delegate = self
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        interfaceSegmented.delegate = self
        joinBtn.setCornerRadius(radius: 15)
        personImage.setCornerRadius(radius: Float(personImage.frame.width)/2)
    }

    func configureView(data: ProfileDataModel) {
        nameLbl.text = "\(data.profileName ?? "")"
        specialityLbl.text = (data.speciality ?? "") + " at \(data.currentLocation ?? "" )"

       // interfaceSegmented.delegate = self

    }

}
extension UserHeaderView: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        
    }
    
    
}
