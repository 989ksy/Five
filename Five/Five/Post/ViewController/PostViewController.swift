//
//  PostViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/7/23.
//

import UIKit
import RxSwift
import RxCocoa

final class PostViewController : BaseViewController, UISheetPresentationControllerDelegate {
    
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
        optionButtonStatus()//고유id를 기준으로 삭제권한 확인
        optionButtonTapped()
        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteTappedInOptionVC), name: NSNotification.Name("VCTransited"), object: nil)
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
    
    ///옵션버튼 상태 (삭제 권한자 확인)
    func optionButtonStatus() {
        // 전달받은 ID값과 로그인 시 저장되어 있는 ID값이 다르면 옵션 키 숨기기
        // 자기 게시글만 삭제 접근 권한 필요하니까.
        if transitedData.value.creator.id != KeychainStorage.shared.userID {
            mainView.optionButton.isHidden = true
        }
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
                
                //좋아요 상태 전달
                if response.likes.contains(KeychainStorage.shared.userID!) {
                    owner.mainView.fiveButton.setImage(UIImage(named: "five.fill")?.withTintColor(CustomColor.pointColor ?? .systemYellow), for: .normal)
                } else {
                    owner.mainView.fiveButton.setImage(UIImage(named: "five"), for: .normal)
                }
                
            }
            .disposed(by: disposeBag)
        
    }
    
    func optionButtonTapped() {
        
        mainView.optionButton
            .rx
            .tap
            .subscribe(with: self) { owner, _ in
                print("tapped")
                
                let vc = OptionViewController()
                vc.modalPresentationStyle = .pageSheet
                vc.postId = self.transitedData.value.id
                
                let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
                let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
                    return 180
                }
                self.sheetPresentationController?.detents = [smallDetent, .medium(), .large()]
                
                if let sheet = vc.sheetPresentationController {
                    //지원할 크기 지정
                    sheet.detents = [smallDetent]
                    //크기 변하는거 감지
                    sheet.delegate = self
                    
                    //시트 상단에 그래버 표시 (기본 값은 false)
                    sheet.prefersGrabberVisible = true
                }
                
                self.present(vc, animated: true, completion: nil)

            }
            .disposed(by: disposeBag)
        
    }
    
    
    @objc func deleteTappedInOptionVC() {
        NotificationCenter.default.post(name: NSNotification.Name("needToUpdate"), object: nil)
        self.navigationController?.popViewController(animated: true)
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
