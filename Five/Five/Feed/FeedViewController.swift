//
//  FeedViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import RxSwift
import RxCocoa

class FeedViewController : BaseViewController {
    
    let mainView = FeedView()
    let viewModel = FeedViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mainView.feedCollectionView.delegate = self
        mainView.feedCollectionView.dataSource = self

        
        setNavigationController()
    }
    
    //MARK: - navigation
    
    func setNavigationController() {
        //타이틀 설정 (로고대용)
        title = "Five"
        
        //로고 UI 설정
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : CustomFont.logo25 ?? .boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor:CustomColor.pointColor ?? .systemYellow]
        
        //네비게이션 컬러
        self.navigationController?.navigationBar.tintColor = .black


        
    }
    
}


extension FeedViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as? FeedCollectionViewCell else {return UICollectionViewCell()}
        
        return cell
    }
    
    
}
