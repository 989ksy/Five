//
//  exploreViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit
import Kingfisher
import RxSwift

final class exploreViewController: BaseViewController {
    
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
    
    
    
    let viewModel = HashViewModel()
    
    var dataSource : UICollectionViewDiffableDataSource<Int, ReadData>!
    
    var fetchData : [ReadData] = [ReadData(likes: [], image: [], hashTags: [], comments: [], id: "", creator: Creator(id: "", nick: "", profile: ""), time: "", content: "", productID: "", ratio: "")]
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        self.navigationItem.titleView = self.searchBar

        
        fetchAllData()
        
        configureDataSource()
        snapshot()
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        
//        Network.shared.requestConvertible(type: Photo.self, api: .search(query: searchBar.text!)) { response in
//            switch response {
//            case .success(let success):
//                //데이터 + UI스냅샷
//                
//                let ratios = success.results.map{ Ratio(ratio: $0.width / $0.height) }
//                // 데이터가 가지고 있는 비율을 가져와서 계산
//                
//                let layout = PinterestLayout(columnsCount: 2, itemRatios: ratios, spacing: 10, contentWidth: self.view.frame.width)
//                
//                
//                self.collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
//                self.configureSnapshot(success)
//                
//                dump(success)
//            case .failure(let failure):
//                print(failure.localizedDescription) //원래 얼럿이나, 토스트알림 띄워야함.
//            }
//        }
//    }
    
    
    
    //explore뷰컨 들어왔을 때 보여줄 전체 데이터
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
    
    
    //cellForItem
    func configureDataSource() {
        
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
