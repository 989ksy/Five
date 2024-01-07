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
        
        //** group이 필요한 요소들
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //(5)repeatingSubitem: NSCollectionLayoutItem//
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)) // **width
        //(4)layoutSize: NSCollectionLayoutSize 구하는 과정
        // .absoulte: 절대적인... 고정되는 수. 따라서, 80이 높이로 고정 됨.
        // .fractionalWidth -> 유동적(상대적)으로 조절된다. (1.0 = 디바이스에 꽉 차게// 0~1 사이 값)
        //.estimated 추가할 시 내용(글자수)에 따라 크기가 바뀜
        
        //** Section이 필요한 요소
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3) //item 2개가 반복됨.
        group.interItemSpacing = .fixed(10) //아이템사이의 간격
        
        //** layout이 필요한 요소
        let section = NSCollectionLayoutSection(group: group)
        //2 (1)의 section 정의. / sectionInset(컬렉션뷰의 상하좌우여백, UIEdgesInset)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) //2-1
        section.interGroupSpacing = 10 // 그룹사이의 간격 (바닥과 탑 사이)
        
        // 가로 스크롤
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical //tag
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        //1 -> section으로 골라오기 때문에 section 정의해줌 / section = cell의 크기
        layout.configuration = configuration
        
        return layout
    }
    
    override func configureView() {
        addSubview(loadCollectionView)
    }
    
    override func setConstraints() {
        
        loadCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}
