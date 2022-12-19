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
    var detailsModel : JobDetailsModel?
    var selectionType : CarrierSelection = .jobDetails
    var detailsVM = JobDetailsViewModel()
    var jobId: Int = 0
    var displayStaus: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsVM.delegate = self
        jobTableView.register(UINib(nibName: "JobDetailsCell", bundle: nil), forCellReuseIdentifier: "JobDetailsCell")
        jobTableView.register(UINib(nibName: "HospitalDetailsCell", bundle: nil), forCellReuseIdentifier: "HospitalDetailsCell")
        
        jobTableView.register(CarrierJobDetailHeaderView.nib, forHeaderFooterViewReuseIdentifier: CarrierJobDetailHeaderView.identifier)

        self.jobTableView.delegate = self
        self.jobTableView.dataSource = self
        self.applyBtn.clipsToBounds = true
        self.applyBtn.layer.cornerRadius = 10
        loadHospitalDetails()
    }
    func loadHospitalDetails() {
        detailsVM.getCarrierJobDetails(JobId: "\(jobId)")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func applyClicked(_ sender: Any) {
        let request = JobApplyRequest(display_status: displayStaus, id: jobId, preference: Preference.jobapply.rawValue)
        let resource = JobsResource()
        self.showLoader()
        resource.applyJob(request: request) { result in
            DispatchQueue.main.async {
                self.dismiss()
                switch result {
                    
                case .success(let data):
                    if data.status  {
                        self.applyBtn.setTitle("Applied", for: .normal)
                        self.applyBtn.isUserInteractionEnabled = false
                    }
                case .failure(_):
                    print("")
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
        return 280
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CarrierJobDetailHeaderView") as? CarrierJobDetailHeaderView {
            if let data = detailsModel {
                headerView.speciality.text = data.eligibility ?? ""
                headerView.location.text = (data.city ?? "") + "," + (data.state ?? "")
                headerView.titileLbl.text =  (data.category ?? "") + " " + (data.Speciality ?? "") 
                headerView.posted.text = "Posted " + (data.created_date ?? "")
                headerView.deleagte = self
                if data.bookmark_status == true {
                    headerView.wishlistBtn.setImage(UIImage(named: "fmark"), for: .normal)
        
                }
                displayStaus = data.display_status ?? 0
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
extension CarrierJobDetailsViewController: JobDetailsViewModelDelegate {
    
    func didReceiveJobDetails(response: JobDetailsModel?, error: String?) {
        self.dismiss()
        if let data = response {
            detailsModel = data
            if data.apply_status ?? false  {
                self.applyBtn.setTitle("Applied", for: .normal)
                applyBtn.isUserInteractionEnabled = false
            }
            jobTableView.reloadData()
        }
    }
    
    
}
