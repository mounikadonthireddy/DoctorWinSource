//
//  EditConnectViewController.swift
//  DoctorWin
//
//  Created by AHP on 07/07/2565 BE.
//

import UIKit

class EditConnectViewController:  ViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    var viewModel =  EditConnectViewModel()
    var profileData: ConnectProfileModel?
    var loadData: Bool = false
    var interestVM = InterestViewModel()
    var interestArray: [InterestModel] = []
    var imagesArray: [GenderImageModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        interestVM.delegate = self
        tableView.register(UINib(nibName: "EditConnectCell", bundle: nil), forCellReuseIdentifier: "EditConnectCell")
        loadInterests()
        // Do any additional setup after loading the view.
        if loadData {
        self.loadProfileData()
            self.loadImagesData()
            viewHeight.constant = 0
            headerView.isHidden = true
        } else {
            viewHeight.constant = 50
            headerView.isHidden = false
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
    }
    func loadProfileData() {
        self.showLoader()
        viewModel.loadProfileData(userId: User.shared.userID)
        
    }
    func loadImagesData() {
        self.showLoader()
        viewModel.loadImagesData(userId: User.shared.userID)
        
    }
    func loadInterests() {
       // self.showLoader()
        interestVM.loadAllInterest()
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
        cell.loadInterestArray(data: interestArray)
        cell.delegate = self
        if let res = profileData {
            cell.configureCell(data: res)
           
        }
        cell.loadImages(array: imagesArray)
        
        
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
    func updateProfile(response: BoolResponseModel?, error: String?) {
        self.dismiss()
    }
    
    func didProfileImageData(response: DatingImagesResponseModel?, error: String?) {
        self.dismiss()
       
        imagesArray = response?.datingResponse ?? []
            self.tableView.reloadData()
        
    }
    
    func didProfileData(response: ConnectProfileResponseModel?, error: String?) {
        self.dismiss()
        if let res = response?.datingResponse {
            profileData = res
            self.tableView.reloadData()
        }
    }
    
    
}
extension EditConnectViewController: InterestViewModelDelegate {
    func submitInterestResponse(res: BoolResponseModel?, error: String?) {
        self.dismiss()
    }
    
    func didInterestData(response: InterestResponseModel?, error: String?) {
        self.dismiss()
        if error == nil {
            interestArray = response?.datingResponse ?? []
            self.tableView.reloadData()
        }
    }
    
    
}
extension EditConnectViewController: connectProfileDelegate {
    func update(request: ConnectProfileRequetModel) {
        self.showLoader()
        viewModel.UpdateProfileData(request: request)
    }
    
    
}
