//
//  MyCasesViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 03/01/22.
//

import UIKit

class MyCasesViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["All Cases","My Cases"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
        }
    }
    var casesArry: [CasesDataModel] = []
    var casesVM = CasesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
    
        interfaceSegmented.delegate = self
        tabBarController?.tabBar.isHidden = false
        self.loadMyCases(index: 0)
        casesVM.delegate = self
        
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
    
    func loadMyCases(index: Int) {
        self.showLoader()
        self.casesVM.getCases(userID: User.shared.userID, index: index)
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  
}

extension MyCasesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casesArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell: CaseCell
            = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
        cell.configureDataWith(homeModel: casesArry[indexPath.row])
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



extension MyCasesViewController: CasesBookMarkDelegate {
    func didReceiveBookmakedCases(response: [CasesDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.casesArry = response ?? []
        self.tableView.reloadData()
        }
    }
    
    
}
extension MyCasesViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        self.showLoader()
        self.casesVM.getCases(userID: User.shared.userID, index: index)
    }
    
    
}
