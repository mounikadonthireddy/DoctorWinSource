//
//  HomeTableHeader.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class HomeTableHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var products: UIButton!
    @IBOutlet weak var education: UIButton!
    @IBOutlet weak var news: UIButton!
    @IBOutlet weak var job: UIButton!
    @IBOutlet weak var connect: UIButton!
    @IBOutlet weak var stack1: BorderView!
    @IBOutlet weak var stack2: BorderView!
    @IBOutlet weak var mentor: UIButton!
    @IBOutlet weak var bgView: UIView!
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}


final class BorderView: UIView {

    private var shadowLayer: CAShapeLayer!

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.borderWidth = 3.5
        self.layer.borderColor = UIColor(rgb: 0xE8E9EB).cgColor
        self.layer.cornerRadius = 10
        
//        if shadowLayer == nil {
//            shadowLayer = CAShapeLayer()
//            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
//            shadowLayer.fillColor = UIColor.white.cgColor
//
//            shadowLayer.shadowColor = UIColor.lightGray.cgColor
//            shadowLayer.shadowPath = shadowLayer.path
//            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//            shadowLayer.shadowOpacity = 0.8
//            shadowLayer.shadowRadius = 2
//            shadowLayer.borderWidth = 2
//
//            layer.insertSublayer(shadowLayer, at: 0)
//            //layer.insertSublayer(shadowLayer, below: nil) // also works
//        }
    }

}
