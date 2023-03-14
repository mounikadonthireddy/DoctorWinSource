//
//  AddMainViewController.swift
//  DoctorWin
//
//  Created by N517325 on 11/11/21.
//

import UIKit
enum AddSelectionType: String {
    case caseDiscussion
    case camera
    case gallary
    case sale
    
}
protocol AddScreenSelectionDelegate: class {
    func didSelectScreen(selectedType: AddSelectionType)
}

class AddMainViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    var views : [UIView]!
    let titleArray = ["Create Post","Add Question"]
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: [ "Create Post","Add Question"])
            interfaceSegmented.selectorViewColor = .blue
            interfaceSegmented.selectorTextColor = .blue
            interfaceSegmented.delegate = self
        }
    }
    /// Instantiate ViewControllers Here With Lazy Keyword
    ///  // MARK: AddCasesViewController
    lazy var vc: CreatePostViewController = {
        
        let str = UIStoryboard(name: "Add", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "CreatePostViewController") as! CreatePostViewController
        viewController.delegate = self
        return viewController
    }()
    
    // MARK: AddCasesViewController
    lazy var vc1: AddQuestionViewController = {
        
        let str = UIStoryboard(name: "Add", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "AddQuestionViewController") as! AddQuestionViewController
     
        return viewController
    }()
    
    
    lazy var vc3: SaleViewController = {
        let str = UIStoryboard(name: "Add", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "SaleViewController") as! SaleViewController
        return viewController
    }()
    // MARK: AddArticalViewController
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        views = [UIView]()
        views.append(vc.view)
        views.append(vc1.view)
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
    @IBAction func closeClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension AddMainViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        containerView.bringSubviewToFront(views[index])
    }
    
    
}
extension AddMainViewController: AddScreenSelectionDelegate {
    func didSelectScreen(selectedType: AddSelectionType) {
        let str = UIStoryboard(name: "Add", bundle: nil)
        switch selectedType {
            
        case .caseDiscussion:
            let viewController = str.instantiateViewController(withIdentifier: "AddCasesViewController") as! AddCasesViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        case .camera:
            print("camera")
        case .gallary:
            print("gallary")
        case .sale:
            
            let viewController = str.instantiateViewController(withIdentifier: "SaleViewController") as! SaleViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
}
