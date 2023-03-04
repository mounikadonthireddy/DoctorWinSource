//
//  SavedJobViewController.swift
//  DoctorWin
//
//  Created by N517325 on 09/11/21.
//

import UIKit

class SavedJobViewController: UIViewController {
    @IBOutlet weak var savedJobTableView: UITableView!
    var savedJobArray :[JobModel] = []
    var customJobVM = CustomJobViewModel()
    weak var jobScreenSelectionDelegate: CustomJobScreenSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        savedJobTableView.register(UINib.init(nibName: "CarrierJobCell", bundle: nil), forCellReuseIdentifier: "CarrierJobCell")
        customJobVM.delegate2 = self
        parse1()
    }
    

    func parse1() {
        customJobVM.getSavedJobs(pageNum: 1)
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension SavedJobViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedJobArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarrierJobCell = tableView.dequeueReusableCell(withIdentifier: "CarrierJobCell") as! CarrierJobCell
        cell.configureCell(with: savedJobArray[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Details", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "CarrierJobDetailsViewController") as! CarrierJobDetailsViewController
        nextVC.jobId = savedJobArray[indexPath.row].id
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
}
extension SavedJobViewController: JobSavedDelegate {
    func didReceiveSavedJobs(response: AppliedJobResponse?, error: String?) {
        self.savedJobArray = response?.jobResponse ?? []
        savedJobTableView.reloadData()
    }
    
//    func didReceiveSavedJobs(response: AppliedJobResponse, error: String?) {
//        self.savedJobArray = response.jobResponse ?? []
//        savedJobTableView.reloadData()
//        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobTypeScreenSelection.savedJob(withCount: self.savedJobArray.count))
//
//    }
}
