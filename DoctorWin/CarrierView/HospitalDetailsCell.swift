//
//  HospitalDetailsCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 05/05/22.
//

import UIKit

class HospitalDetailsCell: UITableViewCell {
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var noOfSpecilities: UILabel!
    @IBOutlet weak var noOfBeds: UILabel!
    @IBOutlet weak var noOfOT: UILabel!
    @IBOutlet weak var dailyPatients: UILabel!
    @IBOutlet weak var NICUC: UILabel!
    @IBOutlet weak var ICU: UILabel!
    @IBOutlet weak var PICU: UILabel!
    @IBOutlet weak var specialitiesCV: UICollectionView!
    @IBOutlet weak var highlightsCV: UICollectionView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionViewLayout1: UICollectionViewFlowLayout!
    var specialityArray: [Hospitalspeciality] = []
    var highlightArray: [Hospitalhighlight] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.specialitiesCV.backgroundColor = UIColor.white
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout1.scrollDirection = .horizontal
        collectionViewLayout1.minimumLineSpacing = 0
        collectionViewLayout1.minimumInteritemSpacing = 0
        collectionViewLayout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        specialitiesCV.register(UINib.init(nibName: "HospitalHighligtCell", bundle: nil), forCellWithReuseIdentifier: "HospitalHighligtCell")
        highlightsCV.register(UINib.init(nibName: "HospitalHighligtCell", bundle: nil), forCellWithReuseIdentifier: "HospitalHighligtCell")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCellWith(data: HospitalDetailsModel) {
        self.location.text = data.location ?? ""
        self.state.text = (data.city ?? "") + (data.state ?? "")
        self.titleLbl.text = (data.name ?? "")
        
        self.noOfSpecilities.text = data.no_of_sepeciality ?? ""
        self.noOfBeds.text = data.no_of_bed ?? ""
        self.noOfOT.text =  data.no_of_OT ?? ""
        
        self.dailyPatients.text = data.daily_OPD ?? ""
        
        self.ICU.text =  "\(data.icu ?? 0)"
        self.NICUC.text = "\(data.nicuc ?? 0)"
        self.PICU.text = "\(data.picu ?? 0)"
        self.specialityArray = data.hospitalspeciality ?? []
        self.highlightArray = data.hospitalhighlight ?? []
        self.specialitiesCV.reloadData()
        self.highlightsCV.reloadData()
        
    }
}

extension HospitalDetailsCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == highlightsCV {
            return highlightArray.count
        } else {
            return specialityArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HospitalHighligtCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HospitalHighligtCell", for: indexPath) as! HospitalHighligtCell
        if collectionView == highlightsCV  {
            cell.configureCell(with: highlightArray[indexPath.row])
        } else {
            cell.configureCell(with: specialityArray[indexPath.row])
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let yourWidth = 80
        return CGSize(width: yourWidth, height: 85)
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
