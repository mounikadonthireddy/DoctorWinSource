//
//  EditConnectViewController.swift
//  DoctorWin
//
//  Created by AHP on 07/07/2565 BE.
//

import UIKit

class EditConnectViewController:  ViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel =  EditConnectViewModel()
    var profileData: ConnectProfileModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.register(UINib(nibName: "EditConnectCell", bundle: nil), forCellReuseIdentifier: "EditConnectCell")
        
        // Do any additional setup after loading the view.
        self.loadProfileData()
     
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
    }
    func loadProfileData() {
        self.showLoader()
        viewModel.loadProfileData(userId: User.shared.userID)
        
    }
    
    
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension EditConnectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:EditConnectCell = tableView.dequeueReusableCell(withIdentifier: "EditConnectCell") as! EditConnectCell
       
      
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
    func didProfileData(response: ConnectProfileResponseModel?, error: String?) {
        self.dismiss()
        if let res = response?.datingResponse {
            profileData = res
            self.tableView.reloadData()
        }
    }
    
    
}
