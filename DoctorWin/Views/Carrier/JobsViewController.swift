//
//  JobsViewController.swift
//  DoctorWin
//
//  Created by N517325 on 25/10/21.
//

import UIKit
import iOSDropDown

class JobsViewController: UIViewController {
    @IBOutlet weak var jobTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var locationTF: DropDown!
    @IBOutlet weak var departmentTF: DropDown!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    var jobType: String = ""
    var categoryID: Int = 0
    var jobsArray :[CarrierModel] = []
    var jobsVM = JobsViewModel()
    var query: Bool = false
    var queryString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobTableView.register(UINib.init(nibName: "CarrierJobCell", bundle: nil), forCellReuseIdentifier: "CarrierJobCell")
        jobsVM.delegate = self
        if query {
            getSearchJobs()
        } else {
        parse1()
        }
      
        self.backBtn.setTitle("  \(jobType)", for: .normal)
        handleSearch()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    func handleSearch() {
        stackViewHeight.constant = 0
    }
    
    func parse1() {
        
        jobsVM.getJobDataBasedOnCategory(userID: User.shared.userID, categoryID: categoryID)
    }
    func getSearchJobs() {
        
        jobsVM.getSearchJobData(userID: User.shared.userID, query: queryString)
    }

    @IBAction func backClicked(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterClikced(_ sender: Any) {
        let str = UIStoryboard(name: "Job", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension JobsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarrierJobCell
        = tableView.dequeueReusableCell(withIdentifier: "CarrierJobCell") as! CarrierJobCell
        cell.configureCell(with: jobsArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Detailsx", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "CarrierJobDetailsViewController") as! CarrierJobDetailsViewController
            nextVC.detailsModel = jobsArray[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)

    }
    
}
extension JobsViewController: JobsViewModelDelegate {
    func didReceiveCarrierResponse(response: [CarrierModel]?, error: String?) {
        
    }
    
    func didReceiveJobsResponse(response: [CarrierModel]?, error: String?) {
        if error == nil {
            jobsArray = response ?? []
            jobTableView.reloadData()
        }
    }
    
    
}
