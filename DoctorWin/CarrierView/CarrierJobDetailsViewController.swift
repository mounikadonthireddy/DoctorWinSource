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
    var detailsModel : CarrierModel?
    var selectionType : CarrierSelection = .jobDetails
    var viewHeight = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobTableView.register(UINib(nibName: "JobDetailsCell", bundle: nil), forCellReuseIdentifier: "JobDetailsCell")
        jobTableView.register(UINib(nibName: "HospitalDetailsCell", bundle: nil), forCellReuseIdentifier: "HospitalDetailsCell")
        
        jobTableView.register(CarrierJobDetailHeaderView.nib, forHeaderFooterViewReuseIdentifier: CarrierJobDetailHeaderView.identifier)
        
//        if detailsModel != nil {
//
//            if response?.apply_status ?? false  {
//                self.applyBtn.setTitle("Applied", for: .normal)
//            }
//            if applyBtn.titleLabel?.text == "Applied" {
//                applyBtn.isUserInteractionEnabled = false
//            }
//        }
        self.jobTableView.delegate = self
        self.jobTableView.dataSource = self
        self.applyBtn.clipsToBounds = true
        self.applyBtn.layer.cornerRadius = 10
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func applyClicked(_ sender: Any) {
        
        if  let jobId = detailsModel?.id {
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
    
}
extension CarrierJobDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if detailsModel != nil {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectionType == .jobDetails {
            let cell: JobDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "JobDetailsCell") as! JobDetailsCell
            if detailsModel != nil {
                cell.configureCellWith(data: detailsModel!)
            }
            return cell
            
        } else {
            let cell: HospitalDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "HospitalDetailsCell") as! HospitalDetailsCell
            if detailsModel != nil {
                cell.configureCellWith(data: detailsModel!)
            }
            return cell
            
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if selectionType == .hospitalDetails {
//            return 80
//        }
        return 280
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CarrierJobDetailHeaderView") as? CarrierJobDetailHeaderView {
            if let data = detailsModel {
                headerView.speciality.text = data.eligibility.reduce("", { ($0.isEmpty ? "" : $0 + ", ") + $1.name })

                headerView.location.text = data.location_of_job ?? ""
                headerView.titileLbl.text = (data.designation ?? "") + " " + (data.Speciality ?? "")
                
                headerView.deleagte = self
//                if selectionType == .hospitalDetails {
//                    headerView.titleView.isHidden = true
//                    headerView.viewHeight.constant = 0
//                    
//                } else {
//                    headerView.titleView.isHidden = false
//                    headerView.viewHeight.constant = 200
//                    
//                }
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
