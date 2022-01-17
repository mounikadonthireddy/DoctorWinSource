//
//  SearchJobsViewController.swift
//  DoctorWin
//
//  Created by N517325 on 09/11/21.
//

import UIKit

class SearchJobsViewController: UIViewController {
    @IBOutlet weak var departmentTF: UITextField!
    @IBOutlet weak var locatiomTF: UITextField!
    @IBOutlet weak var designationtTF: UITextField!
    @IBOutlet weak var recommendedTableView: UITableView!
    var recommedJobsArray :[JobsDataModel] = []
    var jobsVM = JobsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendedTableView.register(UINib.init(nibName: "SearchJobCell", bundle: nil), forCellReuseIdentifier: "SearchJobCell")
        jobsVM.delegate = self
        self.parse1()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    func parse1() {
        
        jobsVM.getAllJobData(userID: User.shared.userID)
        
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchJobsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommedJobsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchJobCell = tableView.dequeueReusableCell(withIdentifier: "SearchJobCell") as! SearchJobCell
        cell.configureCell(with: recommedJobsArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
        nextVC.detailsModel = recommedJobsArray[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension SearchJobsViewController: JobsViewModelDelegate {
    func didReceiveJobsResponse(response: [JobsDataModel]?, error: String?) {
        if error == nil {
            recommedJobsArray = response ?? []
            recommendedTableView.reloadData()
        }
    }
    
    
}
