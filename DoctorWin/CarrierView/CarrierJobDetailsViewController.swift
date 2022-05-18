//
//  CarrierJobDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/05/22.
//

import UIKit

class CarrierJobDetailsViewController: ViewController {
    @IBOutlet weak var jobTableView: UITableView!
    @IBOutlet weak var applyBtn: UIButton!
    var detailsModel : JobsDataModel!
    var jobApplyVM = JobApplyViewModel()
    var jobDetailsVM = CarrierJobDetailsViewModel()
    var jobId = 0
    var hospitalModel : HospitalDetailsModel?
    var jobModel : CarrierJobDetailsModel?
    var selectionType : CarrierSelection = .jobDetails
var viewHeight = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        jobTableView.register(UINib(nibName: "JobDetailsCell", bundle: nil), forCellReuseIdentifier: "JobDetailsCell")
        jobTableView.register(UINib(nibName: "HospitalDetailsCell", bundle: nil), forCellReuseIdentifier: "HospitalDetailsCell")

        jobTableView.register(CarrierJobDetailHeaderView.nib, forHeaderFooterViewReuseIdentifier: CarrierJobDetailHeaderView.identifier)


        self.jobTableView.delegate = self
        self.jobTableView.dataSource = self
        jobDetailsVM.delegate = self
        
        self.applyBtn.clipsToBounds = true
        self.applyBtn.layer.cornerRadius = 10

        self.loadJobDetails()
        self.loadHospitalDetails()
    }
    func loadJobDetails() {
        self.showLoader()
        jobDetailsVM.getCarrierJobDetails(userID: User.shared.userID, JobId: "\(jobId)")
    }
    func loadHospitalDetails() {
        self.showLoader()
        jobDetailsVM.getCarrierHospitalDetails(userID: User.shared.userID, JobId: "\(jobId)")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func applyClicked(_ sender: Any) {
        let request = JobApplyRequest(user_id: User.shared.userID, job_id: "\(jobId)")
        let resource = JobsResource()
        self.showLoader()
        resource.applyJob(request: request) { result in
            DispatchQueue.main.async {
                self.dismiss()
                if result.status  {
                self.applyBtn.setTitle("Applied", for: .normal)
                    self.applyBtn.isUserInteractionEnabled = false
            }
            }
        }
        
    }
   

}
extension CarrierJobDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if jobModel != nil {
        return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectionType == .jobDetails {
            let cell: JobDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "JobDetailsCell") as! JobDetailsCell
            if jobModel != nil {
                cell.configureCellWith(data: jobModel!)
            }
            return cell

        } else {
            let cell: HospitalDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "HospitalDetailsCell") as! HospitalDetailsCell
            if hospitalModel != nil {
                cell.configureCellWith(data: hospitalModel!)
            }
            return cell
            
        }

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if selectionType == .hospitalDetails {
            return 80
        }
        return 280
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CarrierJobDetailHeaderView") as? CarrierJobDetailHeaderView {
            if jobModel != nil {
                headerView.speciality.text = jobModel?.Speciality ?? ""
                headerView.location.text = jobModel?.location ?? ""
                headerView.titileLbl.text = (jobModel?.designation ?? "" ) + (jobModel?.Speciality ?? "")
                headerView.deleagte = self
                if selectionType == .hospitalDetails {
                    headerView.titleView.isHidden = true
                    headerView.viewHeight.constant = 0

                } else {
                    headerView.titleView.isHidden = false
                    headerView.viewHeight.constant = 200

                }
            }
                    headerView.backBtn.addTarget(self, action: #selector(backClicked(button:)), for: .touchUpInside)

         
            return headerView
        }
        
        return nil
        
    }
    @objc func backClicked(button: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
extension CarrierJobDetailsViewController: JobDetailsViewModelDelegate {
    func didReciveHospitalData(response: HospitalDetailsModel?, error: String?) {
        dismiss()
        if response != nil {
            hospitalModel = response
        }
    }
    
    func didReceiveJobDetails(response: CarrierJobDetailsModel?, error: String?) {
        dismiss()
        if response != nil {
            jobModel = response
                    if response?.apply_status ?? false  {
                        self.applyBtn.setTitle("Applied", for: .normal)
                    }
                    if applyBtn.titleLabel?.text == "Applied" {
                        applyBtn.isUserInteractionEnabled = false
                    }
        }
        self.jobTableView.reloadData()
    }
 
}
extension CarrierJobDetailsViewController: CarrierDetailsSelectionType {
    func selectionType(type: CarrierSelection) {
        switch type {
        case .hospitalDetails:
            selectionType = .hospitalDetails
            
        case .jobDetails:
            selectionType = .jobDetails
        }
        jobTableView.reloadData()
    }
    
    
}
