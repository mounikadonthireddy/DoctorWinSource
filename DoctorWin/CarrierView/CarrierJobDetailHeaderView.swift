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
    @IBOutlet weak var wishlistBtn: UIButton!
     var deleagte: CarrierDetailsSelectionType?
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Job Details","About Company"])
            interfaceSegmented.selectorViewColor = .blue
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
