//
//  MyCasesViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 03/01/22.
//

import UIKit

class MyCasesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var homedataArry: [HomeDataModel] = []
    var homeVM = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        homeVM.delegate = self
        tabBarController?.tabBar.isHidden = false
        self.loadMyCases()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.frame = CGRect(x: 0, y: 0, width: 220, height: 100)     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        tabBarController?.tabBar.isHidden = true
    }
    
    func parse() {
        self.showLoader()
        self.homeVM.getNewsPollArticleComplaintDataFromAPI(userID: User.shared.userID)
        
    }
    func loadMyCases() {
        homeVM.getAllCases(userID: User.shared.userID)
    }
    func loadBookmarkCases() {
        homeVM.getBookmarkCases(userID: User.shared.userID)
    }
    func loadLikedCases() {
        homeVM.getLikedCases(userID: User.shared.userID)
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.loadMyCases()
        } else if sender.selectedSegmentIndex == 1 {
            self.loadBookmarkCases()
        } else {
            self.loadLikedCases()
        }
        
        self.showLoader()
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  
}

extension MyCasesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homedataArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell: HomeTableCell
            = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell") as! HomeTableCell
            cell.delegate = self
        cell.configureData(homeModel: homedataArry[indexPath.row])
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if homedataArry[indexPath.row].complaintStatus {
        
//        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeDetailsViewController") as! HomeDetailsViewController
//        nextVC.detailsModel = homedataArry[indexPath.row]
//            
//        self.navigationController?.pushViewController(nextVC, animated: true)
        //}
    }
    @objc func followClicked(button: UIButton) {
        
        
        
    }
    @objc func wishlistClicked(button: UIButton) {
//        if   let data = homedataArry[button.tag].complaintId {
//            homeVM.saveToWishlist(userID: User.shared.userID, categeroyID: "\(data)")
//        }
    }
    @objc func saveClicked(button: UIButton) {
//        if   let data = homedataArry[button.tag].complaintId {
//            homeVM.saveToBookMark(userID: User.shared.userID, categeroyID: "\(data)")
//        }
    }
    @objc func replyBtnClicked(button: UIButton) {
        
    }
}

extension MyCasesViewController: CellActionDelegate {
    func like(url: String) {
        print(url)
    }
    
    func follow(url: String) {
        print(url)
    }
    
    func save(url: String) {
        print(url)
    }
    
    func reply(url: String, replyText: String) {
        print(url)
    }

}


extension MyCasesViewController : HomeViewModelDelegate {
    func didAddedToWishlist(status: Bool?, error: String?) {
        print(status)
    }
    
    func didAddedToFollow(status: Bool, error: String?) {
        
    }
    
    func didAddedToSave(status: Bool, error: String?) {
        
    }
    
    func didReplySent(status: Bool, error: String?) {
        
    }
    
    func didReceiveLoginResponse(response: [HomeDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.homedataArry = response ?? []
        self.tableView.reloadData()
        }
    }
    func showLoader() {
        let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    func dismiss() {
        dismiss(animated: false, completion: nil)
    }
    
}

