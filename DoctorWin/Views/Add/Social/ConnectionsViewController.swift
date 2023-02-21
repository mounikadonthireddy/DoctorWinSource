//
//  ConnectionsViewController.swift
//  DoctorWin
//
//  Created by AHP on 19/09/2565 BE.
//

import UIKit

class ConnectionsViewController: ViewController {
    var views : [UIView]!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
 
    @IBOutlet weak var headerView: UIView!
    lazy var vc1: MatchesViewController = {
        
        let str = UIStoryboard(name: "Network", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "MatchesViewController") as! MatchesViewController
    //    viewController.jobScreenSelectionDelegate = self
        
        return viewController
    }()
    
    // MARK: MARKET ViewController
    
    lazy var vc2: ConnectionLikeViewController = {
        let str = UIStoryboard(name: "Network", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "ConnectionLikeViewController") as! ConnectionLikeViewController
        //viewController.jobScreenSelectionDelegate = self

        return viewController
    }()
    
    // MARK: GRAPH ViewController
    
    lazy var vc3: ChatViewController = {
        let str = UIStoryboard(name: "Network", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
       // viewController.jobScreenSelectionDelegate = self

        return viewController
    }()
    
    lazy var vc4: EditConnectViewController = {
        let str = UIStoryboard(name: "Network", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "EditConnectViewController") as! EditConnectViewController
       // viewController.jobScreenSelectionDelegate = self
        viewController.loadData = true
        return viewController
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn1.alignVertical()
        btn2.alignVertical()
        btn3.alignVertical()
        btn4.alignVertical()
        headerView.dropShadow()
        views = [UIView]()
        views.append(vc1.view)
        views.append(vc2.view)
        views.append(vc3.view)
        views.append(vc4.view)
        for v in views {
            v.frame = containerView.bounds
            containerView.addSubview(v)
        }
        containerView.bringSubviewToFront(views[0])
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    func loadDatingProfiles() {
//        self.showLoader()
//        viewModel.getDatingProfilesData(userID: User.shared.userID)
        
    }

    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func segmentBtnClicked(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            btn1.setTitleColor(UIColor(rgb: 0xF06292), for: .normal)
            btn2.setTitleColor(.black, for: .normal)
            btn3.setTitleColor(.black, for: .normal)
            btn4.setTitleColor(.black, for: .normal)
            btn1.tintColor = UIColor(rgb: 0xF06292)
            btn2.tintColor = .black
            btn3.tintColor = .black
            btn4.tintColor = .black
        case 1:
            btn2.setTitleColor(UIColor(rgb: 0xF06292), for: .normal)
            btn1.setTitleColor(.black, for: .normal)
            btn3.setTitleColor(.black, for: .normal)
            btn4.setTitleColor(.black, for: .normal)
            btn2.tintColor = UIColor(rgb: 0xF06292)
            btn1.tintColor = .black
            btn3.tintColor = .black
            btn4.tintColor = .black
        case 2:
            btn3.setTitleColor(UIColor(rgb: 0xF06292), for: .normal)
            btn2.setTitleColor(.black, for: .normal)
            btn1.setTitleColor(.black, for: .normal)
            btn4.setTitleColor(.black, for: .normal)
            btn3.tintColor = UIColor(rgb: 0xF06292)
            btn2.tintColor = .black
            btn1.tintColor = .black
            btn4.tintColor = .black
        case 3:
            btn4.setTitleColor(UIColor(rgb: 0xF06292), for: .normal)
            btn2.setTitleColor(.black, for: .normal)
            btn3.setTitleColor(.black, for: .normal)
            btn1.setTitleColor(.black, for: .normal)
            btn4.tintColor = UIColor(rgb: 0xF06292)
            btn2.tintColor = .black
            btn3.tintColor = .black
            btn1.tintColor = .black
        default:
            print("nothing selected")
        }
        self.containerView.bringSubviewToFront(views[sender.tag])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIButton {
    func alignVertical(spacing: CGFloat = 6.0) {
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else { return }
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
    }
}
