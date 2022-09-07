//
//  JobDetailsViewController.swift
//  DoctorWin
//
//  Created by N517325 on 31/10/21.
//

import UIKit

class JobDetailsViewController: ViewController {
    @IBOutlet weak var jobTableView: UITableView!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var applyBtn: UIButton!
    var detailsModel : JobsDataModel!
    var jobApplyVM = JobApplyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        jobTableView.register(UINib(nibName: "JobRequirementCell", bundle: nil), forCellReuseIdentifier: "JobRequirementCell")
        jobApplyVM.delegate = self

        self.jobTableView.delegate = self
        self.jobTableView.dataSource = self
        
        self.chatBtn.clipsToBounds = true
        self.chatBtn.layer.cornerRadius = 10
        self.applyBtn.clipsToBounds = true
        self.applyBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        if detailsModel.applyStatus ?? false  {
            self.applyBtn.setTitle("Applied", for: .normal)
        }
        if applyBtn.titleLabel?.text == "Applied" {
            applyBtn.isUserInteractionEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func applyClicked(_ sender: Any) {
        let request = JobApplyRequest(user_id: User.shared.userID, job_id: "\(detailsModel.id!)")
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
    @IBAction func chatClicked(_ sender: Any) {
        
    }

}
extension JobDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JobRequirementCell
            = tableView.dequeueReusableCell(withIdentifier: "JobRequirementCell") as! JobRequirementCell
        cell.configureCell(with: detailsModel)
        cell.backBtn.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)

        return cell
    }
    @objc func pressButton(button: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1400
    }
    
}
extension JobDetailsViewController: JobApplyViewModelDelegate {
    func didReceiveJobsResponse(response: ResponseModel?, error: String?) {
        self.dismiss()
    }
    
    
}
