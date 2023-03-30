//
//  CollectionViewLayout.swift
//  DoctorWin
//
//  Created by AHP on 23/02/2566 BE.
//

import UIKit

let headerKind = "Header"
let footerKind = "Footer"
let sectionBackground = "SectionBackground"

enum LayoutType {
    case headerImageSectionLayout
    case namesLayout
    case categoryLayout
    case fullViewLayout
    case emptyView
    case mentorImage
    case mentorApp
    case mentorServices
    case testimonals
    case doubts
    case dailyUpdates
    case aboutApp
    
    func getLayout(withHeader: Bool = false, height:Int = 0, fractionalWidth: CGFloat = 0.3) -> NSCollectionLayoutSection {
        switch self {
        case .headerImageSectionLayout:
            return AppLayouts.shared.ImageBannerLayout()
        case .categoryLayout:
            return AppLayouts.shared.courseCategoryLayout()
        case .namesLayout:
            return AppLayouts.shared.namesListLayout(fractionalWidth: fractionalWidth)
        case .fullViewLayout:
            return AppLayouts.shared.fullWidthLayout(height: height, header: withHeader)
        case .emptyView:
            return AppLayouts.shared.emptyView()
        case .mentorImage:
            return AppLayouts.shared.MentorImageBanner()
        case .mentorApp:
            return AppLayouts.shared.MentorAppBanner()
        case .mentorServices:
            return AppLayouts.shared.fullWidthLayout1(height: 257, header: true)
        case .testimonals:
            return AppLayouts.shared.TestimonalsLayout()
        case .doubts:
            return AppLayouts.shared.homeSupportLayout()
        case .dailyUpdates:
            return AppLayouts.shared.dailyUpdatesLayout()
        case .aboutApp:
            return AppLayouts.shared.aboutAppLayout()
            
            
//        case .updateProfileLayout:
//            return AppLayouts.shared.updateProfileLayout()
//        case .horizontalDynamicLayout:
//            return AppLayouts.shared.HorizontalDynamicLayout()
//        case .supportLayout:
//            return AppLayouts.shared.SupportLayout()
//        case .profileHederLayout:
//            return AppLayouts.shared.profileHeaderLayout()
//        case .premiumTypeLayout:
//            return AppLayouts.shared.premiumTypeLayout()
//        case .planDetailslayout:
//            return AppLayouts.shared.planDetailsCellLayout()
//        case .idVerification:
//            return AppLayouts.shared.idVerificationDataCellLayout()
        }
        
    }
}
class AppLayouts {
    
    static let shared = AppLayouts()
    
    func courseCategoryLayout() -> NSCollectionLayoutSection {
       
        let cellHeight = NSCollectionLayoutDimension.absolute(150)
        let cellWidth = NSCollectionLayoutDimension.fractionalWidth(1)
        let size = NSCollectionLayoutSize(widthDimension: cellWidth, heightDimension: cellHeight)
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let groupHeight = NSCollectionLayoutDimension.absolute(140)
        let groupWidth = NSCollectionLayoutDimension.absolute(140)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight), subitems: [item])
      
        let section = NSCollectionLayoutSection(group: group)
       
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    func SupportLayout() -> NSCollectionLayoutSection {
        // Cell will be the full height of the enclosing group
        let cellHeight = NSCollectionLayoutDimension.fractionalHeight(1)
        // Cell will be 1/3 width of the enclosing group
        let cellWidth = NSCollectionLayoutDimension.fractionalWidth(1)
        // The size of the cell
        let size = NSCollectionLayoutSize(widthDimension: cellWidth, heightDimension: cellHeight)
        // This item represents a single cell
        let item = NSCollectionLayoutItem(layoutSize: size)
        // The cell will be inset by these distances within the item
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // The group will be a fixed height
        let groupHeight = NSCollectionLayoutDimension.absolute(150)
        // The group will occupy the full available width
        let groupWidth = NSCollectionLayoutDimension.absolute(150)
        // The group will repeat to hold as many of the cells as it can in a horizontal row before wrapping
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight), subitems: [item])
        
        // The actual section, which consists of a single group
        let section = NSCollectionLayoutSection(group: group)
        // The insets of the group from the edge of the collection view
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // Create and assign the layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        // collectionView.collectionViewLayout = layout
        return section
    }
    func ImageBannerLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(95)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0)
        return section
    }
    
    func emptyView() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    func namesListLayout(fractionalWidth: CGFloat) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(fractionalWidth), heightDimension: .absolute(40)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    func viewedMatchesLayout( withHeader: Bool = true ) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(160)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        
        if withHeader {
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), elementKind: headerKind, alignment: .top)
            ]
        }
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    func fullWidthLayout(height: Int, header:Bool) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(CGFloat(height))), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        //  section.orthogonalScrollingBehavior = .paging
       
        if header == true {
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: headerKind, alignment: .top)
            ]
        }
        
        
        //        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: sectionBackground)
        //        section.decorationItems = [decorationItem]
        
        return section
    }
    func fullWidthLayout1(height: Int, header:Bool) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(CGFloat(height))), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 0)
        //  section.orthogonalScrollingBehavior = .paging
       
        if header == true {
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: headerKind, alignment: .top)
            ]
        }
        
        
        //        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: sectionBackground)
        //        section.decorationItems = [decorationItem]
        
        return section
    }
    
    func premiumMatchesLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(180)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        section.orthogonalScrollingBehavior = .paging
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), elementKind: headerKind, alignment: .top),
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70)), elementKind: footerKind, alignment: .bottom)
            
        ]
        
        
        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: sectionBackground)
    
        section.decorationItems = [decorationItem]
        return section
    }
    
    func SearchDetailListLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(280)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 15, bottom: 20, trailing: 15)
        
        return section
    }
    func updateProfileLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(160)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    func profileHeaderLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(440)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    func premiumTypeLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(40)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    func planDetailsCellLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(430)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 5, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    func idVerificationDataCellLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(340)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 5, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    func HorizontalDynamicLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(100), heightDimension: .absolute(30)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15 , bottom: 15, trailing: 15)
        
        return section
    }
    
    func homeSupportLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 5, bottom: 20, trailing: 5)
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: headerKind, alignment: .top)
        ]
       //section.orthogonalScrollingBehavior = .paging
        return section
    }
    func MentorImageBanner() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    func dailyUpdatesLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), elementKind: headerKind, alignment: .top)
            
        ]

//        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: "DaillyDecorationView")
    
        //section.decorationItems = [decorationItem]
      
        return section
    }
    func MentorAppBanner() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(600)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 20, trailing: 0)
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(0)), elementKind: headerKind, alignment: .top)
        ]
        section.orthogonalScrollingBehavior = .none
        return section
    }
    func TestimonalsLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(310)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(310)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 8, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 0, trailing: 5)
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: headerKind, alignment: .top)
        ]
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    func aboutAppLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: headerKind, alignment: .top)
            
        ]

        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: "DaillyDecorationView")
    
        section.decorationItems = [decorationItem]
      
        return section
    }
    
}
class DaillyDecorationView: UICollectionReusableView {
    
    // MARK: MAIN -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        self.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
    }
    
    func setUpViews1(color: UIColor){
        self.backgroundColor = color
    }
    
}
class SectionDecorationView: UICollectionReusableView {
    
    // MARK: MAIN -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        self.backgroundColor = UIColor(red: 27/255, green: 48/255, blue: 40/255, alpha: 1)
    }
    
    func setUpViews1(color: UIColor){
        self.backgroundColor = color
    }
    
}
class SectionHeaderView: UICollectionReusableView {
    
    // MARK: PROPERTIES -
    
    let dividerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        return v
    }()
    
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "  Recommended Jobs"
        l.font = UIFont.boldSystemFont(ofSize: 26)
        l.textColor = UIColor(red: 142/255, green: 37/255, blue: 144/255, alpha: 1.0)
        l.textAlignment = .center
        return l
    }()
    
    // MARK: MAIN -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        addSubview(dividerView)
        addSubview(title)
    }
    
    func setUpConstraints(){

    }
    
}
