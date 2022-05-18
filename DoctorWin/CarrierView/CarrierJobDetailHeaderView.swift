//
//  CarrierJobDetailHeaderView.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/05/22.
//

import UIKit

enum CarrierSelection {
    case hospitalDetails
    case jobDetails
}
protocol CarrierDetailsSelectionType {
    func selectionType(type: CarrierSelection)
}

class CarrierJobDetailHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var titileLbl: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var speciality: UILabel!
    @IBOutlet weak var posted: UILabel!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var backBtn: UIButton!

     var deleagte: CarrierDetailsSelectionType?
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Job Details","Hospital Details"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
            interfaceSegmented.delegate = self
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension CarrierJobDetailHeaderView: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        print(index)
        if index == 0 {
            deleagte?.selectionType(type: .jobDetails)
        } else {
            deleagte?.selectionType(type: .hospitalDetails)

        }
        
    }
    
    
}
