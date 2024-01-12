//
//  SearchView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/5/23.
//

import UIKit
import SnapKit

final class HashView : BaseView {
    
    let searchBar = {
        let bar = UISearchBar()
        bar.placeholder = "토픽 또는 키워드를 검색해 보세요." //"검색"
        bar.searchTextField.textAlignment = .center
        bar.searchTextField.font = CustomFont.mediumGmarket15
        return bar
    }()
    
    lazy var loadCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configurePinterestLayout())
        view.register(LoadCell.self, forCellWithReuseIdentifier: LoadCell.identifier)
        view.backgroundColor = CustomColor.backgroundColor
        return view
    }()
    
    func configurePinterestLayout() -> UICollectionViewLayout {
        
        //** item이 필요한 요소
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(150))
        // **width + .estimated: 그룹사이즈의 반만큼만 너비를 차지할거고, 높이가 그때그때 달라질거야~
        // groupSize의 반만 가져갈게.
        
       
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
       
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)

        layout.configuration = configuration
        
        return layout
    }
    
    override func configureView() {
        addSubview(loadCollectionView)
        loadCollectionView.backgroundColor = .red
    }
    
    override func setConstraints() {
        
        loadCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
}
