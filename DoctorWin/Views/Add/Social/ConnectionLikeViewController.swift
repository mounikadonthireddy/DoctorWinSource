//
//  ConnectionLikeViewController.swift
//  DoctorWin
//
//  Created by AHP on 22/09/2565 BE.
//

import UIKit

class ConnectionLikeViewController: UIViewController {
    @IBOutlet weak var connectLikesCV: UICollectionView!
    @IBOutlet weak var connectLikesLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Who Likes Me", "My Likes"])
            interfaceSegmented.selectorViewColor = .blue
            interfaceSegmented.selectorTextColor = .blue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpCollectionView() {
        connectLikesCV.register(UINib.init(nibName: "ConnectLikeCell", bundle: nil), forCellWithReuseIdentifier: "ConnectLikeCell")
        
        connectLikesLayout.scrollDirection = .vertical
        connectLikesLayout.minimumLineSpacing = 0
        connectLikesLayout.minimumInteritemSpacing = 0
        connectLikesLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
extension ConnectionLikeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell: ConnectLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectLikeCell", for: indexPath) as! ConnectLikeCell
           // cell.configureCell(data: profileInfoArray[indexPath.row])
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
        
    }
    
    
}
