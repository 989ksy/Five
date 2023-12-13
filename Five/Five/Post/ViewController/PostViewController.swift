//
//  PostViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/7/23.
//

import UIKit
import RxSwift
import RxCocoa

final class PostViewController : BaseViewController {
    
    var transitedData = BehaviorRelay(value: ReadData(likes: [], image: [], id: "", creator: Creator.init(id: "", nick: ""), time: "", content: "", productID: ""))
    
    let mainView = PostView()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor //백그라운드 컬러
        
        navigationItem.titleView = mainView.titleStackView
        
        mainView.imageCollectionView.dataSource = self
        mainView.imageCollectionView.delegate = self
        
//        bindData()
    }
    
    /// 네비게이션바 타이틀 설정 (닉네임 - 게시글)
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if view.traitCollection.horizontalSizeClass == .compact {
            mainView.titleStackView.axis = .vertical
            mainView.titleStackView.spacing = UIStackView.spacingUseDefault
        } else {
            mainView.titleStackView.axis = .horizontal
            mainView.titleStackView.spacing = 20.0
        }
    }
    
    
    func bindData() {
        
        transitedData
            .bind(with: self) { owner, response in
                
                //닉네임 (프로필바)
                owner.mainView.nickLabel.text = response.creator.nick
                //내용
                owner.mainView.contentLabel.text = response.content
                //날짜
                owner.mainView.dateLabel.text = response.time
                
            }
            .disposed(by: disposeBag)
        
    }
    
    
    
}


extension PostViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as? PostCollectionViewCell else { return UICollectionViewCell() }
        
        cell.countLabel.text = "\(indexPath.row + 1)/\(indexPath.count)"
        
        return cell
    }
    
    
    
    
}
