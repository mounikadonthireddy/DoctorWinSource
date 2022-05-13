//
//  ConnectCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 13/05/22.
//

import UIKit
import iOSDropDown

class ConnectCell: UITableViewCell {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var bioTF: UITextField!
    @IBOutlet weak var livingTF: UITextField!
    @IBOutlet weak var qualificationTF: DropDown!
    @IBOutlet weak var professionTF: DropDown!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var interest: UIButton!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    var ImageArray: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        courseCollectionView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
        self.courseCollectionView.delegate = self
        self.courseCollectionView.dataSource = self
        self.courseCollectionView.backgroundColor = UIColor.white
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ConnectCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell

//        cell.name.text = courseArray[indexPath.item].name
//        cell.name.backgroundColor = UIColor.white
//        cell.backgroundColor = UIColor.white
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let yourWidth = CGFloat(40)
        return CGSize(width: yourWidth, height: collectionView.bounds.height)

    }
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          
            return 0
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           
            return 0
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
