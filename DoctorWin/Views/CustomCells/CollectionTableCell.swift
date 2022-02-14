//
//  CollectionTableCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit
protocol RecommendedJobSelectionDelegate: class {
    func recommendedJobSelection(data:JobsDataModel)
}

class CollectionTableCell: UITableViewCell {
    var jobsArray : [JobsDataModel] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    weak var selectionDelegate: RecommendedJobSelectionDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib.init(nibName: "RecommandedJobCell", bundle: nil), forCellWithReuseIdentifier: "RecommandedJobCell")

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
    func configureCell(with dataArray: [JobsDataModel]) {
        jobsArray = dataArray
        collectionView.reloadData()
        
    }
}
extension CollectionTableCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecommandedJobCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandedJobCell", for: indexPath) as! RecommandedJobCell
        cell.configureCell(with: jobsArray[indexPath.row])

        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let yourWidth = self.frame.width 
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionDelegate?.recommendedJobSelection(data: jobsArray[indexPath.row])
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
