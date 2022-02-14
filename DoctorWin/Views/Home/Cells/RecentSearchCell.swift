//
//  RecentSearchCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit

class RecentSearchCell: UITableViewCell {
    var searchArray : [RecentSearchModel] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    weak var deleagte:SearchJobDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib.init(nibName: "RecentSearchCVCell", bundle: nil), forCellWithReuseIdentifier: "RecentSearchCVCell")

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(with dataArray: [RecentSearchModel]) {
        searchArray = dataArray
        collectionView.reloadData()

    }
}
extension RecentSearchCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecentSearchCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentSearchCVCell", for: indexPath) as! RecentSearchCVCell
        cell.cellConfigureWith(data: searchArray[indexPath.row])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 202, height: 90)

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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = searchArray[indexPath.row].search
        let finalString = "location=" + data.location + "&designation=" + data.disignation + "&department=" + data.department
        deleagte?.SearchJobDelegate(query: finalString, jobType: data.location)
    }
    
    
}
