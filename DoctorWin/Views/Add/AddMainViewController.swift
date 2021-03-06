//
//  AddMainViewController.swift
//  DoctorWin
//
//  Created by N517325 on 11/11/21.
//

import UIKit

class AddMainViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var currentTitle: UILabel!
    @IBOutlet weak var nextTitle: UILabel!
    
    var views : [UIView]!
    let titleArray = ["Cases", "News", "Poll", "Article"]
    
    /// Instantiate ViewControllers Here With Lazy Keyword
    // MARK: AddCasesViewController
    lazy var vc1: AddCasesViewController = {
        
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "AddCasesViewController") as! AddCasesViewController
        
        return viewController
    }()
    
    // MARK: AddNewsViewController
    
    lazy var vc2: AddNewsViewController = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "AddNewsViewController") as! AddNewsViewController
        
        return viewController
    }()
    
    // MARK: AddPollViewController
    
    lazy var vc3: AddPollViewController = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "AddPollViewController") as! AddPollViewController
        return viewController
    }()
    // MARK: AddArticalViewController
    
    lazy var vc4: AddArticalViewController = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "AddArticalViewController") as! AddArticalViewController
        return viewController
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
   
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        containerView.bringSubviewToFront(views[sender.selectedSegmentIndex])
        self.currentTitle.text = titleArray[sender.selectedSegmentIndex]
        
        if sender.selectedSegmentIndex < 0 || sender.selectedSegmentIndex == titleArray.count - 1 {
            self.nextTitle.isHidden = true
        } else {
            self.nextTitle.text = titleArray[sender.selectedSegmentIndex + 1]
        }
        
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
