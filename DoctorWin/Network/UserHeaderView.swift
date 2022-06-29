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
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var followCountBtn: UIButton!
    @IBOutlet weak var followingCountBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var qualificationLbl: UILabel!
    @IBOutlet weak var specialityLbl: UILabel!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Social","Cases", "News", "Articles"])
            interfaceSegmented.selectorViewColor = .blue
            interfaceSegmented.selectorTextColor = .black
            //interfaceSegmented.delegate = self
        }
    }

    func configureView(data: ProfileDataModel) {
        nameLbl.text = "Dr. \(data.profileName ?? "")"
        specialityLbl.text = (data.speciality ?? "") + " at \(data.currentLocation ?? "" )"
        qualificationLbl.text = data.qualification ?? ""
        followCountBtn.setTitle("\(data.follow ?? 0) Followers", for: .normal)
        followingCountBtn.setTitle("\(data.following ?? 0) Following", for: .normal)
       // interfaceSegmented.delegate = self

    }

}
