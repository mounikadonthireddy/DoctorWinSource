//
//  ShowInterestViewController.swift
//  DoctorWin
//
//  Created by AHP on 01/07/2565 BE.
//

import UIKit

class ShowInterestViewController: ViewController {
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileName1: UILabel!
    @IBOutlet weak var profileSpeciality: UILabel!
    @IBOutlet weak var profileLocation: UILabel!
    @IBOutlet weak var aboutProfile: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var hiBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var interestCV: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var interestCV1: UICollectionView!
    @IBOutlet weak var collectionViewLayout1: UICollectionViewFlowLayout!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeight1: NSLayoutConstraint!
    var viewModel = DatingViewModel()
    var datingArray : [DatingModel]  = []
    var timer: Timer?
    var currentImage: UIImage?
    var currentIndex = -1
    var presentProfileIndex = 0
    var imagesArray: [GenderImageModel] = []
    var interestsArray: [ProfileInterestModel] = []
    private var lastContentOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        self.loadDatingProfiles()
        likeBtn.setCornerRadius(radius: Float(likeBtn.frame.width)/2)
        rejectBtn.setCornerRadius(radius: Float(rejectBtn.frame.width)/2)
        hiBtn.setCornerRadius(radius: Float(hiBtn.frame.height)/2)
        
        // Do any additional setup after loading the view.
        interestCV.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
        interestCV1.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
    
        self.interestCV.backgroundColor = UIColor.clear
        self.interestCV1.backgroundColor = UIColor.clear

        collectionViewLayout.scrollDirection = .vertical
        interestCV.isScrollEnabled = false
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionViewLayout1.scrollDirection = .vertical
        interestCV1.isScrollEnabled = false
        collectionViewLayout1.minimumLineSpacing = 0
        collectionViewLayout1.minimumInteritemSpacing = 0
        collectionViewLayout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func loadDatingProfiles() {
        self.showLoader()
        viewModel.getDatingProfilesData(userID: User.shared.userID)
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView!) {
            if (self.lastContentOffset > scrollView.contentOffset.y) {
                profileName1.isHidden = false
                interestCV1.isHidden = false
            }
            else if (self.lastContentOffset < scrollView.contentOffset.y) {
               // move down
            }

            // update the new position
            self.lastContentOffset = scrollView.contentOffset.y
        }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       // isScrolling = true1
        profileName1.isHidden = true
        interestCV1.isHidden = true
        
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("End scrolling")
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            profileName1.isHidden = false
            interestCV1.isHidden = false
        }
    }
    
    @objc func timerAction(){
        
        if imagesArray.count > 0 {
            currentIndex = (currentIndex == imagesArray.count - 1) ? 0 : currentIndex + 1
            let urlString = self.imagesArray[self.currentIndex].image
            
            self.profileImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
            
            self.currentImage = self.profileImage.image
            self.pageControl.currentPage = self.currentIndex
            
        }
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func chatClicked(_ sender: Any) {
        
    }
    @IBAction func messageClicked(_ sender: Any) {
        
    }
    @IBAction func editProfileClicked(_ sender: Any) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ConnectViewController") as! ConnectViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func blockClicked(_ sender: Any) {
        
    }
    @IBAction func rejectClicked(_ sender: Any) {
        
    }
    @IBAction func wishlistClicked(_ sender: Any) {
        
    }
    
}
extension ShowInterestViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell
        
        cell.name.text = interestsArray[indexPath.item].interest
        cell.backgroundColor = UIColor.white
        cell.setCornerRadiusWithBorderColor(radius: 17.5, color: UIColor.secondaryLabel, borderWidth: 0.5)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (interestsArray[indexPath.row].interest as NSString).size(withAttributes: nil)
        return CGSize(width: size.width + 20, height: 30)
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
extension ShowInterestViewController: DatingViewModelDelegate {
    func didReciveDatingData(response: [DatingModel]?, error: String?) {
        self.dismiss()
        datingArray = response ?? []
        if datingArray.count > 0 {
            interestsArray = datingArray[0].interest
            imagesArray = datingArray[0].genderimage
            interestCV.reloadData()
            interestCV1.reloadData()
            profileName.textColor = UIColor.black
            profileSpeciality.text = datingArray[0].profession
            profileLocation.text = datingArray[0].living
            aboutProfile.text = datingArray[0].intro
           collectionViewHeight.constant = CGFloat(interestsArray.count * 30)
         //   nameTopConstant.constant =  -collectionViewHeight.constant
            collectionViewHeight1.constant = CGFloat((interestsArray.count/3) * 30)
            profileName.text = datingArray[0].name
            profileName1.text = datingArray[0].name
           if imagesArray.count > 0 {
                self.startTimer()
                pageControl.numberOfPages = imagesArray.count
              
            }
            
        }
        
    }
    
    
}

