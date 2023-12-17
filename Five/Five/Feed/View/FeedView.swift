//
//  FeedView.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import SnapKit

class FeedView: BaseView {
    
    
    let feedCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: "FeedCollectionViewCell")
        view.backgroundColor = CustomColor.backgroundColor
        return view
    }()
    
    let addContentButton = {
        let btn = AddContentButton()
        return btn
    }()
    
    let profileViewUpperLine = {
        let view = LineView()
        return view
    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width , height: 520)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 0
        
        return layout
    }
    
    override func configureView() {
        
        addSubview(profileViewUpperLine)
        addSubview(feedCollectionView)
        addSubview(addContentButton)
        
    }
    
    override func setConstraints() {
        
        profileViewUpperLine.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
        }

        feedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        addContentButton.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }

        
        
    }
    
    
}
