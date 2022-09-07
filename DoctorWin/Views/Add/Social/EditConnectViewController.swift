//
//  EditConnectViewController.swift
//  DoctorWin
//
//  Created by AHP on 07/07/2565 BE.
//

import UIKit

class EditConnectViewController:  ViewController {
    @IBOutlet weak var tableView: UITableView!
    var qualificationArray: [QualificationModel] = []
    var professionArray: [ProfessionModel] = []
    var viewModel =  EditConnectViewModel()
    var profileData: ConnectProfileModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.register(UINib(nibName: "EditConnectCell", bundle: nil), forCellReuseIdentifier: "EditConnectCell")
        
        // Do any additional setup after loading the view.
        self.loadProfileData()
        downloadQualificationResource()
        downloadProfessionalResource()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
    }
    func loadProfileData() {
        self.showLoader()
        viewModel.loadAllInterest(userId: User.shared.userID)
        
    }
    func downloadQualificationResource() {
        self.showLoader()
        let resouce = DropDownResource()
        resouce.getQualificationData { result in
            DispatchQueue.main.async {
                self.dismiss()
                switch result {
                case .success(let data):
                    self.qualificationArray = data
                    self.tableView.reloadData()
                    
                case .failure(_):
                    print("")
                }
                
            }
        }
    }
    func downloadProfessionalResource() {
        self.showLoader()
        let resouce = DropDownResource()
        resouce.getProfessionalData { result in
            DispatchQueue.main.async {
                self.dismiss()
                switch result {
                case .success(let data):
                    self.professionArray = data
                    self.tableView.reloadData()
                    
                case .failure(_):
                    print("")
                }
            
            }
        }
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension EditConnectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:EditConnectCell = tableView.dequeueReusableCell(withIdentifier: "EditConnectCell") as! EditConnectCell
        cell.professionTF.optionArray = professionArray.map({ data in
            return data.position
        })
        cell.qualificationTF.optionArray = qualificationArray.map({ data in
            return data.qualification
        })
        cell.genderTF.optionArray = ["Male", "Female"]
        if let res = profileData {
            cell.configureCell(data: res)
        }
        
        cell.interest.addTarget(self, action: #selector(interstClicked(button:)), for: .touchUpInside)
        return cell
    }
    
    @objc func interstClicked(button: UIButton) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "InterstViewController") as! InterstViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
extension EditConnectViewController: EditConnectProfileDelegate {
    func didProfileData(response: ConnectProfileModel?, error: String?) {
        self.dismiss()
        if let res = response {
            profileData = res
            self.tableView.reloadData()
        }
    }
    
    
}
