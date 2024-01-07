//
//  ProfileView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit
import SnapKit

class ProfileView : BaseView {

    
    let fiveCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.register(FiveCollectionViewCell.self, forCellWithReuseIdentifier: "FiveCollectionViewCell")
        view.register(FivedCollectionViewCell.self, forCellWithReuseIdentifier: "FivedCollectionViewCell")
        view.register(ProfileCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileCollectionHeaderView.identifier)
        view.backgroundColor = CustomColor.backgroundColor
        return view
    }()
    
    
//    let fivedView = {
//        let view = ()
//        view.backgroundColor = .blue
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 3
        let numberOfItemsInRow: CGFloat = 3
        
        let width = (UIScreen.main.bounds.width - (numberOfItemsInRow + 1) * spacing) / numberOfItemsInRow
        layout.itemSize = CGSize(width: width, height: width)
        
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 260)
        
        return layout
        
    }
    
    let addContentButton = {
        let btn = AddContentButton()
        return btn
    }()
    
    override func configureView() {
        [
            fiveCollectionView,
            addContentButton,
        ]
            .forEach { self.addSubview($0) }
        
        
        
    }
    
    
    
    
    override func setConstraints() {
        
        fiveCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        addContentButton.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }       
    }
    
}
