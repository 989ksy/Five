//
//  HashViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit
import Kingfisher
import RxSwift

final class HashViewController: BaseViewController {
    
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
    
    
    
//    let mainView = HashView()
    let viewModel = HashViewModel()
    
    var dataSource : UICollectionViewDiffableDataSource<Int, ReadData>!
    
    var fetchData : [ReadData] = [ReadData(likes: [], image: [], hashTags: [], comments: [], id: "", creator: Creator(id: "", nick: "", profile: ""), time: "", content: "", productID: "", ratio: "")]
    
    let disposeBag = DisposeBag()
    
//    override func loadView() {
//        self.view = mainView
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
//        self.navigationItem.titleView = mainView.searchBar
        self.navigationItem.titleView = self.searchBar

        
        fetchAllData()
        
        configureDataSource()
        snapshot()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func fetchAllData() {
        
        viewModel.fetchReadData { response in
            
            switch response {
                
            case .success(let success):
                self.fetchData = success.data
                
                let ratios = success.data.map{
                    Ratio(ratio: Double($0.ratio ?? "") ?? 1.0)
                }

                let layout = PinterestLayout(
                    columnsCount: 2,
                    itemRatios: ratios,
                    spacing: 10,
                    contentWidth: self.view.frame.width
                )
                
                self.loadCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                
                self.snapshot()
                
                print("------전체 데이터 로딩 중:", self.fetchData)
                
            case .failure(let failure):
                print("fetchAllData failed",failure.rawValue)
                print(failure.errorDescription!)
            }
        }
        
    }
    
    
    
    func configureDataSource() { //cellForItem
        
        let cellRegistration = UICollectionView.CellRegistration<LoadCell, ReadData> { cell, indexPath, itemIdentifier in
            
            let imageUrl = URL(string: "\(BaseURL.base)" + (itemIdentifier.image.first ?? ""))
            cell.mainImage.kf.setImage(with: imageUrl)
            
        }
        
        //데이터소스
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.loadCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
    }
    
    func snapshot() {
        //reloadData role
        var snapshot = NSDiffableDataSourceSnapshot<Int, ReadData>()
        snapshot.appendSections([0])
        snapshot.appendItems(fetchData)
        dataSource.apply(snapshot)
    }
    
    
    func configurePinterestLayout() -> UICollectionViewLayout {
        
        //** item이 필요한 요소
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(150))
        // **width + .estimated: 그룹사이즈의 반만큼만 너비를 차지할거고, 높이가 그때그때 달라질거야~
        // groupSize의 반만 가져갈게.
        
       
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.interItemSpacing = .fixed(2)
        
        let section = NSCollectionLayoutSection(group: group)
       
        section.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        section.interGroupSpacing = 2
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)

        layout.configuration = configuration
        
        return layout
    }
    
    
    override func configureView() {
        
        view.addSubview(loadCollectionView)

        
    }
    
    override func setConstraints() {
        loadCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    
}
