//
//  ConnectionLikeViewController.swift
//  DoctorWin
//
//  Created by AHP on 22/09/2565 BE.
//

import UIKit

class ConnectionLikeViewController: ViewController {
    @IBOutlet weak var connectLikesCV: UICollectionView!
    @IBOutlet weak var connectLikesLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Who Likes Me", "My Likes"])
            interfaceSegmented.selectorViewColor = .blue
            interfaceSegmented.selectorTextColor = .blue
        }
    }
    var datingVM = LikedDatingViewModel()
    var likesArray :[LikeMatchesModel] = []
    var likedArray :[LikeMatchesModel] = []
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        datingVM.delegate = self
        interfaceSegmented.delegate = self
        loadOtherLikedProfiles()
        
        // Do any additional setup after loading the view.
    }
    func loadLikedProfiles() {
        self.showLoader()
        datingVM.getDatingProfilesData(userID: User.shared.userID)
    }
    func loadOtherLikedProfiles() {
        self.showLoader()
        datingVM.getOtherLikedProfilesData(userID: User.shared.userID)
    }
    func setUpCollectionView() {
        connectLikesCV.register(UINib.init(nibName: "ConnectLikeCell", bundle: nil), forCellWithReuseIdentifier: "ConnectLikeCell")
        
        connectLikesLayout.scrollDirection = .vertical
        connectLikesLayout.minimumLineSpacing = 0
        connectLikesLayout.minimumInteritemSpacing = 0
        connectLikesLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}
extension ConnectionLikeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedIndex == 0 {
            return likedArray.count
        } else if selectedIndex == 1{
            return likesArray.count
        }
       return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell: ConnectLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectLikeCell", for: indexPath) as! ConnectLikeCell
        if selectedIndex == 0 {
            cell.configureCell(data: likedArray[indexPath.row])
        } else {
            cell.configureCell(data: likesArray[indexPath.row])
        }
           
            cell.dropShadow()
            return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let yourWidth = collectionView.bounds.width/2 - 20
            return CGSize(width: yourWidth, height: 270)
      
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ConnectionLikeViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        selectedIndex = index
        if index == 1 {
            self.loadLikedProfiles()
        } else if index == 0 {
            self.loadOtherLikedProfiles()
        }
    }
    
    
}
extension ConnectionLikeViewController: LikedDatingViewModelDelegate {
    func didOtherLikedDatingData(response: [LikeMatchesModel]?, error: String?) {
        self.dismiss()
        self.likedArray = response ?? []
        self.connectLikesCV.reloadData()
    }
    
    func didReciveDatingData(response: [LikeMatchesModel]?, error: String?) {
        self.dismiss()
        self.likesArray = response ?? []
        self.connectLikesCV.reloadData()
    }
  
    
}
