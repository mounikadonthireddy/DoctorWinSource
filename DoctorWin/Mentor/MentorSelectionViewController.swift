//
//  MentorSelectionViewController.swift
//  DoctorWin
//
//  Created by AHP on 22/03/2566 BE.
//

import UIKit

class MentorSelectionViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    var navTitle: String = ""
    var descTitle: String = ""
    var type: Bool = false
    var id: Int = 0
    var serviceVM = MentorServicesViewModel()
    var servicesArray: [ServiceModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "AppointmentCell", bundle: nil), forCellReuseIdentifier: "AppointmentCell")
        tableView.register(UINib(nibName: "CounsellingCell", bundle: nil), forCellReuseIdentifier: "CounsellingCell")
        tableView.register(UINib(nibName: "AboutCounsellingCell", bundle: nil), forCellReuseIdentifier: "AboutCounsellingCell")
        tableView.register(TitleView.nib, forHeaderFooterViewReuseIdentifier: TitleView.identifier)
        tableView.contentInsetAdjustmentBehavior = .never
        serviceVM.delegate = self
        backBtn.setTitle(navTitle, for: .normal)
        getServiceData()
        // Do any additional setup after loading the view.
    }
    func getServiceData() {
        self.showLoader()
        serviceVM.getTestimonalsDataFromAPI(id: id)
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }


}
extension MentorSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if type {
                let cell: CounsellingCell
                = tableView.dequeueReusableCell(withIdentifier: "CounsellingCell") as! CounsellingCell
                return cell
            } else {
                let cell: AppointmentCell
                = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell") as! AppointmentCell
                return cell
            }
            
        } else {
            let cell: AboutCounsellingCell
            = tableView.dequeueReusableCell(withIdentifier: "AboutCounsellingCell") as! AboutCounsellingCell
            cell.descLbl.text = descTitle
            cell.titlleLbl.text = navTitle
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return servicesArray[section].category ?? ""
        }
        return "kjhgfdsdfghj"
    }
    
}
extension MentorSelectionViewController: MentorServicesViewModelDelegate {
    func didReciveServicesData(response: ServicesResponseModel?, error: String?) {
        self.dismiss()
        self.servicesArray = response?.description ?? []
       
        tableView.reloadData()
        
    }

}
