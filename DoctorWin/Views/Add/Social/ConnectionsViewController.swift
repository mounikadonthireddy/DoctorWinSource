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

        return viewController
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
