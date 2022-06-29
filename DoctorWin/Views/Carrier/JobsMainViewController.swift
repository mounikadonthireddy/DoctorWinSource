//
//  JobsMainViewController.swift
//  DoctorWin
//
//  Created by N517325 on 28/10/21.
//

import UIKit
enum JobType: String {
    case superSpecialities = "Super Specilities"
    case graduation = "Graduation"
    case academics = "Academics"
    case teleJobs = "Tele Job"
    case freelancer = "Freelancers"
    case specilities = "Specilitie"
    case none
    
}
enum JobScreenSelection {
    case jobWithType(withtype: JobType, categoryID: Int)
//    case superSpecialities
//    case graduation
//    case academics
//    case teleJobs
//    case freelancer
    case recommandedJob(withModel: JobsDataModel)
    case customJob
    case savedJob
    case appliedJob
    case college(withModel : CollegeDataModel)
    case predictor


}
protocol JobScreenSelectionDelegate: class {
    func didSelectScreen(selectedType: JobScreenSelection)
}



class JobsMainViewController: UIViewController {
    @IBOutlet weak var carrierTableView: CarrierTableView!
    @IBOutlet weak var predictorTableView: CarrierTableView!
    
    @IBOutlet weak var containerView: UIView!
    var views : [UIView]!
    
    /// Instantiate ViewControllers Here With Lazy Keyword
    // MARK: Order ViewController
    lazy var vc1: CarrierViewController = {
        
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "CarrierViewController") as! CarrierViewController
        viewController.navigationController?.isNavigationBarHidden = true
        viewController.jobScreenSelectionDelegate = self
        
        return viewController
    }()
    
    // MARK: MARKET ViewController
    
    lazy var vc2: CollegeViewController = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "CollegeViewController") as! CollegeViewController
        viewController.jobScreenSelectionDelegate = self

        return viewController
    }()
    
    // MARK: GRAPH ViewController
    
    lazy var vc3: PredictorViewController = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "PredictorViewController") as! PredictorViewController
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
            v.isUserInteractionEnabled = true
            v.frame = containerView.bounds
            containerView.addSubview(v)
        }
        containerView.bringSubviewToFront(views[0])
        self.navigationController?.isNavigationBarHidden = true

    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        // tabBarController?.tabBar.isHidden = true
    }
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        containerView.bringSubviewToFront(views[sender.selectedSegmentIndex])
        
    }
    @IBAction func searchClicked(_ sender: UIButton) {
        let str = UIStoryboard(name: "Job", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "SearchJobsViewController") as! SearchJobsViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}
extension JobsMainViewController : JobScreenSelectionDelegate {
    func didSelectScreen(selectedType: JobScreenSelection) {
        print("called \(selectedType)")
        let str = UIStoryboard(name: "Home", bundle: nil)

        switch selectedType {
        case .college(let data):
            let nextVC = str.instantiateViewController(withIdentifier: "CollegeDetailsViewController") as! CollegeDetailsViewController
            nextVC.collegeDataModel = data
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case .appliedJob, .customJob, .savedJob:
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomJobMainViewController") as! CustomJobMainViewController
            self.navigationController?.pushViewController(nextVC, animated: true)

        case .recommandedJob(let data):
            
            let nextVC = str.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
            nextVC.detailsModel = data
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case . jobWithType(let type, let id):
            
        
        let nextVC = str.instantiateViewController(withIdentifier: "JobsViewController") as! JobsViewController
            nextVC.jobType = "type"
            nextVC.categoryID = id
        self.navigationController?.pushViewController(nextVC, animated: true)
            
        default:
            let nextVC = str.instantiateViewController(withIdentifier: "CollegeDetailsViewController") as! CollegeDetailsViewController
           
            self.navigationController?.pushViewController(nextVC, animated: true)
        }

    }
    
    
}
