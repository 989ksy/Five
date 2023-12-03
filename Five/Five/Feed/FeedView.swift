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
        return view
    }()
    
    let addContentButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "customPlus")?.withTintColor(.white), for: .normal)
        btn.backgroundColor = CustomColor.pointColor
        btn.layer.cornerRadius = 30
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize.zero
        btn.layer.shadowRadius = 6
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 12
        let width = UIScreen.main.bounds.width - (spacing)
        layout.itemSize = CGSize(width: width , height: 320)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
    
    override func configureView() {
        
        addSubview(feedCollectionView)
        addSubview(addContentButton)
        
    }
    
    override func setConstraints() {
        

        feedCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        addContentButton.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.trailing.equalToSuperview().inset(23)
            make.bottom.equalToSuperview().inset(45)
        }

        
        
    }
    
    
}
