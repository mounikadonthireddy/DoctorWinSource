//
//  CustomJobMainViewController.swift
//  DoctorWin
//
//  Created by N517325 on 09/11/21.
//

import UIKit
enum CustomJobType: String {
    case superSpecialities = "Super Specilities"
    case graduation = "Graduation"
    case academics = "Academics"
    case teleJobs = "Tele Jobs"
    case freelancer = "Freelancers"
    case specilities = "Specilities"
    case none
    
}
enum JobTypeScreenSelection {
    case jobWithType(withtype: JobType, categoryID: Int)
//    case superSpecialities
//    case graduation
//    case academics
//    case teleJobs
//    case freelancer
    case jobDetails(withModel: JobsDataModel)
    case customJob(withCount: Int)
    case savedJob(withCount: Int)
    case appliedJob(withCount: Int)
    case customJobCreate


}
protocol CustomJobScreenSelectionDelegate: class {
    func didSelectScreen(selectedType: JobTypeScreenSelection)
}
class CustomJobMainViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var views : [UIView]!
    
    /// Instantiate ViewControllers Here With Lazy Keyword
    // MARK: Order ViewController
    lazy var vc1: CustomJobViewController = {
        
        let str = UIStoryboard(name: "Job", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "CustomJobViewController") as! CustomJobViewController
        viewController.jobScreenSelectionDelegate = self
        
        return viewController
    }()
    
    // MARK: MARKET ViewController
    
    lazy var vc2: SavedJobViewController = {
        let str = UIStoryboard(name: "Job", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "SavedJobViewController") as! SavedJobViewController
        viewController.jobScreenSelectionDelegate = self

        return viewController
    }()
    
    // MARK: GRAPH ViewController
    
    lazy var vc3: AppliedJobViewController = {
        let str = UIStoryboard(name: "Job", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "AppliedJobViewController") as! AppliedJobViewController
        viewController.jobScreenSelectionDelegate = self

        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        views = [UIView]()
        views.append(vc1.view)
        views.append(vc2.view)
        views.append(vc3.view)
        
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
    }
    
    
    @IBAction func backBtClikced(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        containerView.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
}
extension CustomJobMainViewController: CustomJobScreenSelectionDelegate {
    func didSelectScreen(selectedType: JobTypeScreenSelection) {
        switch selectedType {
        case .customJob(let value):
            segmentControl.setTitle("Custom Jobs(\(value))", forSegmentAt: 0)
            
        case .appliedJob(let value):
            segmentControl.setTitle("Applied Jobs(\(value))", forSegmentAt: 2)
            
        case .savedJob(let value):
            segmentControl.setTitle("Saved Jobs(\(value))", forSegmentAt: 1)
            
        case .jobDetails(let data):
            let str = UIStoryboard(name: "Details", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
            nextVC.detailsModel = data
            self.navigationController?.pushViewController(nextVC, animated: true)

        case .customJobCreate:
            let str = UIStoryboard(name: "Job", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "CreateCustomJobViewController") as! CreateCustomJobViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            break
        }
    }
    
    
}
