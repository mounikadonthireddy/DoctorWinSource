//
//  CarrierTabViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 22/04/22.
//

import UIKit

class CarrierTabViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var allJobsArray :[JobsDataModel] = []
    var categoryJobsViewModel = JobCategoryViewModel()
    var jobsVM = JobsViewModel()
    var recommendJobsArray: [JobsDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInsetAdjustmentBehavior = .never
        
        
        
        tableView.register(UINib.init(nibName: "CarrierJobCell", bundle: nil), forCellReuseIdentifier: "CarrierJobCell")
        
        
        tableView.register(TitleView.nib, forHeaderFooterViewReuseIdentifier: TitleView.identifier)
        
        jobsVM.delegate = self
        parse()
        parse1()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        
    }
    func parse1() {
        jobsVM.getAllJobData(userID: User.shared.userID)
    }
    func parse() {
        self.showLoader()
        categoryJobsViewModel.getTopRecommendedJobs(userID: User.shared.userID)
    }
    
    
    
    
}
extension CarrierTabViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allJobsArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CarrierJobCell
        = tableView.dequeueReusableCell(withIdentifier: "CarrierJobCell") as! CarrierJobCell
        //            cell.configureCell(with: recentSearchArray)
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        if indexPath.section == 2 {
            let nextVC = str.instantiateViewController(withIdentifier: "JobsViewController") as! JobsViewController
            // nextVC.detailsModel = allJobsArray[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        if indexPath.section == 5 {
            let nextVC = str.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
            nextVC.detailsModel = allJobsArray[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
}
extension CarrierTabViewController: JobsViewModelDelegate {
    func didReceiveJobsResponse(response: [JobsDataModel]?, error: String?) {
        self.dismiss()
        if error == nil {
            allJobsArray = response ?? []
            tableView.reloadData()
        }
    }
    
    
}

extension CarrierTabViewController: QuickJobCellSelectionDelegate {
    func quickCellSelecte(jobType: String, categoryID: Int) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "JobsViewController") as! JobsViewController
        nextVC.jobType = jobType
        nextVC.categoryID = categoryID
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension CarrierTabViewController: RecommendedJobSelectionDelegate {
    func recommendedJobSelection(data: JobsDataModel) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
        nextVC.detailsModel = data
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}

//extension CarrierTabViewController: SearchJobDelegate {
//    func textFeildSelection(type: String) {
//        let str = UIStoryboard(name: "Home", bundle: nil)
//        let nextVC = str.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
//        nextVC.inputArray =  speacilityArray.map{ data in
//            return data.department
//        }
//
//        self.navigationController?.pushViewController(nextVC, animated: true)
//    }
//
//    func SearchJobDelegate(query: String, jobType: String) {
//        let str = UIStoryboard(name: "Home", bundle: nil)
//        let nextVC = str.instantiateViewController(withIdentifier: "JobsViewController") as! JobsViewController
//        nextVC.jobType = jobType
//        nextVC.query = true
//        nextVC.queryString = query
//        self.navigationController?.pushViewController(nextVC, animated: true)
//    }
//}

