//
//  HomeViewController.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class HomeViewController: UIViewController, ExpandableLabelDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questionBtn: UIButton!
    var homedataArry: [HomeDataModel] = []
    var homeVM = HomeViewModel()
    @IBOutlet weak var plusBtn: UIButton!
    var states : Array<Bool>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plusBtn.setCornerRadius(radius: Float(plusBtn.frame.width)/2)
        questionBtn.setCornerRadius(radius: Float(questionBtn.frame.height)/2)
        tableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        tableView.register(UINib(nibName: "PollTableViewCell", bundle: nil), forCellReuseIdentifier: "PollTableViewCell")
        tableView.register(UINib(nibName: "ArticalCell", bundle: nil), forCellReuseIdentifier: "ArticalCell")
        
        
        
        tableView.register(CreateFirstCaseView.nib, forHeaderFooterViewReuseIdentifier: CreateFirstCaseView.identifier)
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        homeVM.delegate = self
        tabBarController?.tabBar.isHidden = false
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.blue
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        if #available(iOS 13, *)
        {
            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.1098039216, blue: 0.3137254902, alpha: 1)
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        } else {
            // ADD THE STATUS BAR AND SET A CUSTOM COLOR
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.1098039216, blue: 0.3137254902, alpha: 1)
            }
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
      //  tabBarController?.tabBar.frame = CGRect(x: 0, y: 0, width: 220, height: 100)
        self.parse()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //        tabBarController?.tabBar.isHidden = true
    }
    
    func parse() {
//        self.showLoader()
//        self.homeVM.getNewsPollArticleComplaintDataFromAPI(userID: User.shared.userID)
        
    }
    
   
    @IBAction func postQuestionClicked(_ sender: Any) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        
        let nextVC = str.instantiateViewController(withIdentifier: "PostQuestionViewController") as! PostQuestionViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @IBAction func plusClikced(_ sender: Any) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        
        let nextVC = str.instantiateViewController(withIdentifier: "AddMainViewController") as! AddMainViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homedataArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if homedataArry[indexPath.row].pollStatus ?? false {
            let cell: PollTableViewCell
            = tableView.dequeueReusableCell(withIdentifier: "PollTableViewCell") as! PollTableViewCell
            cell.configureData(homeModel: homedataArry[indexPath.row])
            
            return cell
        }  else if homedataArry[indexPath.row].artStatus ?? false {
            
            
            let cell: ArticalCell
            = tableView.dequeueReusableCell(withIdentifier: "ArticalCell") as! ArticalCell
            cell.configureData(homeModel: homedataArry[indexPath.row])
            cell.descriptionLable.delegate = self
            
            cell.descriptionLable.setLessLinkWith(lessLink: "Close", attributes: [.foregroundColor:UIColor.red], position: .left)
            
            cell.layoutIfNeeded()
            
            cell.descriptionLable.shouldCollapse = true
            cell.descriptionLable.textReplacementType = .word
            cell.descriptionLable.numberOfLines = 5
            cell.descriptionLable.collapsed = states[indexPath.row]
            cell.descriptionLable.text = homedataArry[indexPath.row].articalDiscription
            return cell
        } else {
            let cell: HomeTableCell
            = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell") as! HomeTableCell
            cell.delegate = self
            cell.configureData(homeModel: homedataArry[indexPath.row])
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CreateFirstCaseView.identifier) as? CreateFirstCaseView {
            headerView.postBtn.addTarget(self, action: #selector(postClicked(button:)), for: .touchUpInside)
            //            headerView.configureCollectionView()
            //
            return headerView
        }
        
        return nil
        
    }
    @objc func postClicked(button: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateCaseViewController") as! CreateCaseViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if homedataArry[indexPath.row].complaintStatus {
            
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeDetailsViewController") as! HomeDetailsViewController
            nextVC.detailsModel = homedataArry[indexPath.row]
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    @objc func followClicked(button: UIButton) {
        
        
        
    }
    @objc func wishlistClicked(button: UIButton) {
        if   let data = homedataArry[button.tag].complaintId {
            homeVM.saveToWishlist(userID: User.shared.userID, categeroyID: "\(data)")
        }
    }
    @objc func saveClicked(button: UIButton) {
        if   let data = homedataArry[button.tag].complaintId {
            homeVM.saveToBookMark(userID: User.shared.userID, categeroyID: "\(data)")
        }
    }
    @objc func replyBtnClicked(button: UIButton) {
        
    }
    @objc   func willExpandLabel(_ label: ExpandableLabel) {
       // tableView.beginUpdates()
    }
    
    @objc  func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ArticalDetailsViewController") as! ArticalDetailsViewController
            nextVC.articalDetails = homedataArry[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
//        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
//            states[indexPath.row] = false
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//            }
//        }
//        tableView.endUpdates()
    }
    
    @objc func willCollapseLabel(_ label: ExpandableLabel) {
       // tableView.beginUpdates()
    }
    
    @objc  func didCollapseLabel(_ label: ExpandableLabel) {
//        let point = label.convert(CGPoint.zero, to: tableView)
//        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
//            states[indexPath.row] = true
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//            }
//        }
//        tableView.endUpdates()
    }
}


extension HomeViewController: CellActionDelegate {
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


extension HomeViewController : HomeViewModelDelegate {
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
            states = [Bool](repeating: true, count: homedataArry.count)
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

