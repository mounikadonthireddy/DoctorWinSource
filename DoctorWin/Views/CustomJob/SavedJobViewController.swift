//
//  SavedJobViewController.swift
//  DoctorWin
//
//  Created by N517325 on 09/11/21.
//

import UIKit

class SavedJobViewController: UIViewController {
    @IBOutlet weak var savedJobTableView: UITableView!
    var savedJobArray :[JobsDataModel] = []
    var customJobVM = CustomJobViewModel()
    weak var jobScreenSelectionDelegate: CustomJobScreenSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        savedJobTableView.register(UINib.init(nibName: "CarrierSubCell", bundle: nil), forCellReuseIdentifier: "CarrierSubCell")
        customJobVM.delegate = self
        parse1()
    }
    

    func parse1() {
        customJobVM.getSavedJobs(userID: User.shared.userID)
    }

}

extension SavedJobViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedJobArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarrierSubCell = tableView.dequeueReusableCell(withIdentifier: "CarrierSubCell") as! CarrierSubCell
        cell.configureCell(with: savedJobArray[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobTypeScreenSelection.jobDetails(withModel: savedJobArray[indexPath.row]))
        
    }
    
    
}
extension SavedJobViewController: CustomJobViewModelDelegate {
    func didReceiveCustomJobs(response: [JobsDataModel]?, error: String?) {
        self.savedJobArray = response ?? []
        savedJobTableView.reloadData()
        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobTypeScreenSelection.savedJob(withCount: self.savedJobArray.count))

    }
}
