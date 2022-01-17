//
//  CustomJobViewController.swift
//  DoctorWin
//
//  Created by N517325 on 09/11/21.
//

import UIKit

class CustomJobViewController: UIViewController {
    @IBOutlet weak var customJobTableView: UITableView!
    var customJobArray :[JobsDataModel] = []
    var customJobVM = CustomJobViewModel()
    weak var jobScreenSelectionDelegate: CustomJobScreenSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        customJobTableView.register(UINib.init(nibName: "CarrierSubCell", bundle: nil), forCellReuseIdentifier: "CarrierSubCell")
        customJobVM.delegate = self
        
        parse1()
        // Do any additional setup after loading the view.
    }
    
    func parse1() {
        customJobVM.getCustomJobs(userID: User.shared.userID)
        
    }
    @IBAction func createCliced(_ sender: Any) {
        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobTypeScreenSelection.customJobCreate)
    }
    
}

extension CustomJobViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customJobArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarrierSubCell = tableView.dequeueReusableCell(withIdentifier: "CarrierSubCell") as! CarrierSubCell
        cell.configureCell(with: customJobArray[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobTypeScreenSelection.jobDetails(withModel: customJobArray[indexPath.row]))
    }
    
}
extension CustomJobViewController: CustomJobViewModelDelegate {
    func didReceiveCustomJobs(response: [JobsDataModel]?, error: String?) {
        self.customJobArray = response ?? []
        if customJobArray.count > 0 {
            customJobTableView.isHidden = false
            customJobTableView.reloadData()
        }
       
        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobTypeScreenSelection.customJob(withCount: self.customJobArray.count))
    }
    
    
}
