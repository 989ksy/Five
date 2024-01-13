//
//  exploreViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit
import Kingfisher
import RxSwift

final class exploreViewController: BaseViewController, UISearchBarDelegate {
    
    //MARK: - UI
    
    let searchBar = {
        let bar = UISearchBar()
        bar.placeholder = "토픽 또는 키워드를 검색해 보세요." //"검색"
        bar.searchTextField.textAlignment = .center
        bar.searchTextField.font = CustomFont.mediumGmarket15
        return bar
    }()
    
    lazy var exploreCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configurePinterestLayout())
        view.register(LoadCell.self, forCellWithReuseIdentifier: LoadCell.identifier)
        view.backgroundColor = CustomColor.backgroundColor
        return view
    }()
    
    //MARK: - 선언
    
    let viewModel = HashViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, ReadData>!
    
    //전체 데이터
    var fetchData: [ReadData] = [ReadData(likes: [], image: [], hashTags: [], comments: [], id: "", creator: Creator(id: "", nick: "", profile: ""), time: "", content: "", productID: "", ratio: "")]
    
    //해시태그 데이터
    var hashData: [HashData] = [HashData(likes: [], image: [], hashTags: [], comments: [], id: "", creator: Creator(id: "", nick: "", profile: ""), time: "", content: "", productID: "")]
    
    let disposeBag = DisposeBag()
    
    
    //MARK: - 시점
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        self.navigationItem.titleView = self.searchBar
        
        searchBar.delegate = self
        
        fetchAllData()//전체데이터 불러옴
        
        configureDataSource()
        snapshot()
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    
    //MARK: - 네트워크 통신
    
    
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
                
                self.exploreCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                
                self.snapshot()
                
                print("------전체 데이터 로딩 중:", self.fetchData)
                
            case .failure(let failure):
                print("fetchAllData failed",failure.rawValue)
                print(failure.errorDescription!)
            }
        }
        
    }
    
    
    //검색했을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let hashword = searchBar.text else { return }
        
        
        viewModel.fetchHashData(hashtag: hashword) { response in
            
            print("000000000000000", response)
            
            switch response {
                
            case .success(let success):
                self.hashData = success.data
                
                //컨텐츠1어디감진짜
                
                //                let ratios = success.data.map{
                //                    Ratio(ratio: Double($0.ratio ?? "") ?? 1.0)
                //                }
                //
                //                let layout = PinterestLayout(
                //                    columnsCount: 2,
                //                    itemRatios: ratios,
                //                    spacing: 10,
                //                    contentWidth: self.view.frame.width
                //                )
                //
                //                self.loadCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: layout.section)
                
                self.snapshot()
                
                print("------전체 해시태그 데이터 로딩 중:", self.hashData)
                
            case .failure(let failure):
                print("fetchAllData failed",failure.rawValue)
                print(failure.errorDescription!)
                
            }
        }
        
        
    }
    
    
    
    //MARK: - DiffableDataSource 설정
    
    //cellForItem
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<LoadCell, ReadData> { cell, indexPath, itemIdentifier in
            
            let imageUrl = URL(string: "\(BaseURL.base)" + (itemIdentifier.image.first ?? ""))
            cell.mainImage.kf.setImage(with: imageUrl)
            
        }
        
        //데이터소스
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.exploreCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
    }
    
    //갱신
    func snapshot() {
        //reloadData role
        var snapshot = NSDiffableDataSourceSnapshot<Int, ReadData>()
        snapshot.appendSections([0])
        snapshot.appendItems(fetchData)
        dataSource.apply(snapshot)
    }
    
    //컬렉션뷰 레이아웃
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
    
    
    //MARK: - UI 등록 + 레이아웃 설정
    
    override func configureView() {
        view.addSubview(exploreCollectionView)
    }
    
    override func setConstraints() {
        exploreCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    
}
