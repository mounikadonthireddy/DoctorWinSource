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
    @IBOutlet weak var plusBtn: UIButton!
    var homedataArry: [HomeDataModel] = []
    var homeVM = HomeViewModel()
    var loadingData = true
    var pageNumber = 1
    var states : Array<Bool>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plusBtn.setCornerRadius(radius: Float(plusBtn.frame.width)/2)
        questionBtn.setCornerRadius(radius: Float(questionBtn.frame.height)/2)
        tableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        
        
        
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        tableView.register(UINib(nibName: "ExamCell", bundle: nil), forCellReuseIdentifier: "ExamCell")
        
        tableView.register(HomeTableHeader.nib, forHeaderFooterViewReuseIdentifier: HomeTableHeader.identifier)
        
        
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
            //            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame))
            //            statusBar.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.1098039216, blue: 0.3137254902, alpha: 1)
            //            UIApplication.shared.keyWindow?.addSubview(statusBar)
        } else {
            // ADD THE STATUS BAR AND SET A CUSTOM COLOR
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.1098039216, blue: 0.3137254902, alpha: 1)
            }
            UIApplication.shared.statusBarStyle = .lightContent
        }
        self.loadHomeData(pageNum: pageNumber)
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        //  tabBarController?.tabBar.frame = CGRect(x: 0, y: 0, width: 220, height: 100)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //        tabBarController?.tabBar.isHidden = true
    }
    
    func loadHomeData(pageNum: Int) {
        self.showLoader()
        self.homeVM.getNewsPollArticleComplaintDataFromAPI(userID: User.shared.userID, pageNum: pageNum)
        
    }
    
    
    @IBAction func postQuestionClicked(_ sender: Any) {
        let str = UIStoryboard(name: "Details", bundle: nil)
        
        let nextVC = str.instantiateViewController(withIdentifier: "PostQuestionViewController") as! PostQuestionViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @IBAction func plusClikced(_ sender: Any) {
        let str = UIStoryboard(name: "Add", bundle: nil)
        
        let nextVC = str.instantiateViewController(withIdentifier: "AddMainViewController") as! AddMainViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homedataArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CaseCell
        = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
        cell.delegate = self
        cell.configureData(homeModel: homedataArry[indexPath.row])
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        cell.postImage.tag = indexPath.row
        cell.postImage?.addGestureRecognizer(tapGestureRecognizer)
        cell.layoutIfNeeded()
        return cell
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = homedataArry.count - 1
        if !loadingData && indexPath.row == lastElement {
            self.showLoader()
            loadingData = true
            pageNumber += 1
            self.loadHomeData(pageNum: pageNumber)
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableHeader.identifier) as? HomeTableHeader {
            headerView.news.addTarget(self, action: #selector(newsClicked(button:)), for: .touchUpInside)
            headerView.job.addTarget(self, action: #selector(jobClicked(button:)), for: .touchUpInside)
            headerView.connect.addTarget(self, action: #selector(connectClicked(button:)), for: .touchUpInside)
            headerView.products.addTarget(self, action: #selector(productsClicked(button:)), for: .touchUpInside)
            headerView.education.addTarget(self, action: #selector(educationClicked(button:)), for: .touchUpInside)
            
            return headerView
        }
        
        return nil
        
    }
    @objc func newsClicked(button: UIButton) {
        let str = UIStoryboard(name: "Me", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "MyNewsViewController") as! MyNewsViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    @objc private func didTapImageView(_ sender: UITapGestureRecognizer) {
        let str = UIStoryboard(name: "Details", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ImageDetailsViewController") as! ImageDetailsViewController
        if let image = homedataArry[sender.view?.tag ?? 0].postImage {
            nextVC.selectedImageUrl = image
        }
        nextVC.data = homedataArry[sender.view?.tag ?? 0].postTitle ?? ""
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    @objc func educationClicked(button: UIButton) {
    }
    @objc func productsClicked(button: UIButton) {
        let str = UIStoryboard(name: "Shop", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ShopViewController") as! ShopViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func connectClicked(button: UIButton) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ShowInterestViewController") as! ShowInterestViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func jobClicked(button: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionsViewController") as! QuestionsViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func explainClicked(button: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ExamDetailsViewController") as! ExamDetailsViewController
        // nextVC.examData = homedataArry[button.tag]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        if homedataArry[indexPath.row].complaintStatus ?? false {
        let str = UIStoryboard(name: "Details", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "CaseDetailsViewController") as! CaseDetailsViewController
        nextVC.detailsModel = homedataArry[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
        //        } else if homedataArry[indexPath.row].newsStatus ?? false {
        //            let str = UIStoryboard(name: "Details", bundle: nil)
        //            let nextVC = str.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        //            nextVC.newsDetails = homedataArry[indexPath.row]
        //            self.navigationController?.pushViewController(nextVC, animated: true)
        //        } else if homedataArry[indexPath.row].articalStatus ?? false {
        //            let str = UIStoryboard(name: "Details", bundle: nil)
        //            let nextVC = str.instantiateViewController(withIdentifier: "ArticalDetailsViewController") as! ArticalDetailsViewController
        //            nextVC.articalDetails = homedataArry[indexPath.row]
        //            self.navigationController?.pushViewController(nextVC, animated: true)
        //        } else {
        //            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ExamDetailsViewController") as! ExamDetailsViewController
        //            //nextVC.detailsModel = homedataArry[indexPath.row]
        //            self.navigationController?.pushViewController(nextVC, animated: true)
        //        }
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
    @objc   func willExpandLabel(_ label: ExpandableLabel) {
        // tableView.beginUpdates()
    }
    
    @objc  func didExpandLabel(_ label: ExpandableLabel) {
        
        
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
    func didReciveHomeData(response: [HomeDataModel]?, error: String?) {
        self.dismiss()
        loadingData = false
        if (error != nil) {
            let alert = UIAlertController(title: "Error", message: error!, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            self.homedataArry = homedataArry + (response ?? [])
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

