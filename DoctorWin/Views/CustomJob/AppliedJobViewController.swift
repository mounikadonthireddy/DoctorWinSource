//
//  AppliedJobViewController.swift
//  DoctorWin
//
//  Created by N517325 on 09/11/21.
//

import UIKit

class AppliedJobViewController: ViewController {
    @IBOutlet weak var appliedJobTableView: UITableView!
    var appliedJobArray :[CarrierModel] = []
    var customJobVM = AppliedJobViewModel()
    var showBack:Bool = false
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backViewHeight: NSLayoutConstraint!

    weak var jobScreenSelectionDelegate: CustomJobScreenSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

//        if !showBack {
//            backView.isHidden = true
//            backViewHeight.constant = 0
//        }
        customJobVM.delegate = self
        appliedJobTableView.register(UINib.init(nibName: "CarrierJobCell", bundle: nil), forCellReuseIdentifier: "CarrierJobCell")
        // Do any additional setup after loading the view.
        parse1()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func parse1() {
        self.showLoader()
        customJobVM.getAppliedJobs(userID: User.shared.userID)
        
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension AppliedJobViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appliedJobArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarrierJobCell
        = tableView.dequeueReusableCell(withIdentifier: "CarrierJobCell") as! CarrierJobCell
        cell.configureCell(with: appliedJobArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Home", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "CarrierJobDetailsViewController") as! CarrierJobDetailsViewController
            nextVC.jobId = appliedJobArray[indexPath.row].id
            self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension AppliedJobViewController: AppliedJobViewModelDelegate {
    func didReceiveAppliedJobs(response: [CarrierModel]?, error: String?) {
        self.dismiss()
        self.appliedJobArray = response ?? []
        appliedJobTableView.reloadData()
        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobTypeScreenSelection.appliedJob(withCount: self.appliedJobArray.count))
    }
    
    
    func didReceiveCustomJobs(response: [JobsDataModel]?, error: String?) {
        

    }
    
    
}
