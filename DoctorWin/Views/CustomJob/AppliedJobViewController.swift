//
//  AppliedJobViewController.swift
//  DoctorWin
//
//  Created by N517325 on 09/11/21.
//

import UIKit

class AppliedJobViewController: UIViewController {
    @IBOutlet weak var appliedJobTableView: UITableView!
    var appliedJobArray :[JobsDataModel] = []
    var customJobVM = CustomJobViewModel()
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
        appliedJobTableView.register(UINib.init(nibName: "AppliedJobCell", bundle: nil), forCellReuseIdentifier: "AppliedJobCell")
        // Do any additional setup after loading the view.
        parse1()
    }
    
    func parse1() {
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
        let cell: AppliedJobCell = tableView.dequeueReusableCell(withIdentifier: "AppliedJobCell") as! AppliedJobCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobTypeScreenSelection.jobDetails(withModel: appliedJobArray[indexPath.row]))
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
        nextVC.detailsModel = appliedJobArray[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension AppliedJobViewController: CustomJobViewModelDelegate {
    func didReceiveCustomJobs(response: [JobsDataModel]?, error: String?) {
        self.appliedJobArray = response ?? []
        appliedJobTableView.reloadData()
        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobTypeScreenSelection.appliedJob(withCount: self.appliedJobArray.count))

    }
    
    
}
