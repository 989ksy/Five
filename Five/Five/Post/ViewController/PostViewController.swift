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
        
        bindData()
        setMenu()
    }
    
    /// 네비게이션바 타이틀 위치 설정 (닉네임 - 게시글)
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
    
    @objc func buttonHandler(_ sender: UIButton) {
        
        }
    
    
    func bindData() {
        transitedData
            .bind(with: self) { owner, response in
                
                //닉네임 (네비게이션바)
                if let titleLabel = owner.mainView.titleStackView.arrangedSubviews[0] as? UILabel {
                    titleLabel.text = "@\(response.creator.nick)"
                }
                //닉네임 (프로필바)
                owner.mainView.nickLabel.text = response.creator.nick
                //내용
                owner.mainView.contentLabel.text = response.content
                //날짜
                owner.mainView.dateLabel.customDateFormat(initialText: response.time)
            }
            .disposed(by: disposeBag)
        
    }
    
    func setMenu() {
        
        var items: [UIAction] {
            let delete = UIAction(
                title: "삭제",
                image: UIImage(named: "Trash_Custom"),
                handler: { [unowned self] _ in
                    print("tapped?")
                })
            let Items = [delete]
            return Items
        }
        
        let menu = UIMenu(title: "",
                          children: items)
        
        mainView.optionButton.menu = menu
        mainView.optionButton.showsMenuAsPrimaryAction = true
        
    }
    
    
    
}


//MARK: - CollectionView 설정

extension PostViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - 이미지
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transitedData.value.image.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as? PostCollectionViewCell else { return UICollectionViewCell() }
        
        cell.countLabel.text = "\(indexPath.row + 1)/\(transitedData.value.image.count)"
        
        let imageUrls = transitedData.value.image[indexPath.item]

           let imageUrlString = String(imageUrls)

           let pic = URL(string: "\(BaseURL.base)" + imageUrlString)

           cell.uploadedImaegView.loadImage(from: pic!, placeHolderImage: UIImage(named: "personal"))

        return cell
    }
    
    
}
