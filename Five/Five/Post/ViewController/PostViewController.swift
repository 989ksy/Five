//
//  PostViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/7/23.
//

import UIKit
import RxSwift
import RxCocoa

enum PostTransitionType: String {
    case feed
    case profile
}


final class PostViewController : BaseViewController, UISheetPresentationControllerDelegate {
    
    var type : PostTransitionType = .feed
    
    var transitedData = BehaviorRelay(value: ReadData(likes: [], image: [], hashTags: [], comments: [], id: "", creator: Creator(id: "", nick: "", profile: ""), time: "", content: "", productID: "", ratio: ""))
    var fiveSatus = BehaviorSubject(value: false)
    
    //프로파일VC -> 포스트VC 값전달 때 사용
    var profileTransitedData = BehaviorRelay(value: ReadData(likes: [], image: [], hashTags: [], comments: [], id: "", creator: Creator(id: "", nick: "", profile: ""), time: "", content: "", productID: "", ratio: ""))
    
    let mainView = PostView()
    let disposeBag = DisposeBag()
    
    var isliked: Bool? //PostVC
    var isFived: Bool? //FeedVC 전달값

    var likeCount: Int? //포스트VC 좋아요갯수 저장소
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor //백그라운드 컬러
        
        navigationItem.titleView = mainView.titleStackView
        
        mainView.imageCollectionView.dataSource = self
        mainView.imageCollectionView.delegate = self
        
        configureData()
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
        
        switch type {
        case .feed:
            if transitedData.value.creator.id != KeychainStorage.shared.userID {
                mainView.optionButton.isHidden = true
            }
        case .profile:
            if profileTransitedData.value.creator.id != KeychainStorage.shared.userID {
                mainView.optionButton.isHidden = true
            }
        }
        
    }
    
    func configureData() {
        
        switch type {
        case .feed:
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
                    
                    //좋아요 갯수
                    owner.mainView.fiveCountLabel.text = "공감 \(response.likes.count)개"
                    self.likeCount = response.likes.count
                    
                    
                    //좋아요 상태 전달
                    //받아온 상태값에 따라 손바닥 색 유무 파단
                    if response.likes.contains(KeychainStorage.shared.userID!) {
                        owner.mainView.fiveButton.setImage(UIImage(named: "five.fill")?.withTintColor(CustomColor.pointColor ?? .systemYellow), for: .normal)
                    } else {
                        owner.mainView.fiveButton.setImage(UIImage(named: "five"), for: .normal)
                    }
                    
                    //좋아요 버튼 상태 바꾸기
                    
                    owner.mainView.fiveButton
                        .rx
                        .tap
                        .flatMap{
                            APIManager.shared.likePost(id: self.transitedData.value.id)
                        }
                        .subscribe(with: self) { owner, result in
                            switch result {
                            case .success(let response):
                                self.isliked = response.likeStatus
                                
                                if self.isliked == true {
                                    owner.mainView.fiveButton.setImage(UIImage(named: "five.fill")?.withTintColor(CustomColor.pointColor ?? .systemYellow), for: .normal)
                                    owner.mainView.fiveCountLabel.text = "공감 \((self.likeCount ?? 0) + 1)개"
                                } else {
                                    owner.mainView.fiveButton.setImage(UIImage(named: "five"), for: .normal)
                                    owner.mainView.fiveCountLabel.text = (self.likeCount != 0) ? "공감 \((self.likeCount ?? 0) - 1)개" : "0개"
                                }
                                
                                NotificationCenter.default.post(name: NSNotification.Name("needToUpdate"), object: nil)
                                
                            case .failure(let failure):
                                print("like error: \(failure)")
                                print(failure.errorDescription!)
                            }
                        }
                        .disposed(by: self.disposeBag)
                    
                    
                }
                .disposed(by: disposeBag)
            
        case .profile:
            
            print("프로파일 입성")
            profileTransitedData
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
                    //받아온 상태값에 따라 손바닥 색 유무 파단
                    if response.likes.contains(KeychainStorage.shared.userID!) {
                        owner.mainView.fiveButton.setImage(UIImage(named: "five.fill")?.withTintColor(CustomColor.pointColor ?? .systemYellow), for: .normal)
                    } else {
                        owner.mainView.fiveButton.setImage(UIImage(named: "five"), for: .normal)
                    }
                    
                    //좋아요 버튼 상태 바꾸기
                    
                    owner.mainView.fiveButton
                        .rx
                        .tap
                        .flatMap{
                            APIManager.shared.likePost(id: self.transitedData.value.id)
                        }
                        .subscribe(with: self) { owner, result in
                            switch result {
                            case .success(let response):
                                self.isliked = response.likeStatus
                                
                                if self.isliked == true {
                                    owner.mainView.fiveButton.setImage(UIImage(named: "five.fill")?.withTintColor(CustomColor.pointColor ?? .systemYellow), for: .normal)
                                } else {
                                    owner.mainView.fiveButton.setImage(UIImage(named: "five"), for: .normal)
                                }
                                
                                NotificationCenter.default.post(name: NSNotification.Name("needToUpdate"), object: nil)
                                
                            case .failure(let failure):
                                print("like error: \(failure)")
                                print(failure.errorDescription!)
                            }
                        }
                        .disposed(by: self.disposeBag)
                    
                    
                }
                .disposed(by: disposeBag)
        }
        
        
    }
    
    
    
    ///옵션 버튼 선택
    ///게시글 삭제하는 곳으로 화면전환
    func optionButtonTapped() {
        
        switch type {
        case .feed:
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
            
        case .profile:
            mainView.optionButton
                .rx
                .tap
                .subscribe(with: self) { owner, _ in
                    print("tapped")
                    
                    let vc = OptionViewController()
                    vc.modalPresentationStyle = .pageSheet
                    vc.postId = self.profileTransitedData.value.id
                    
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
        
        switch type {
        case .feed :
            return transitedData.value.image.count
        case .profile :
            return profileTransitedData.value.image.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as? PostCollectionViewCell else { return UICollectionViewCell() }
        
        
        switch type{
        case .feed :
            cell.countLabel.text = "\(indexPath.row + 1)/\(transitedData.value.image.count)"
            
            let imageUrls = transitedData.value.image[indexPath.item]
            
            let imageUrlString = String(imageUrls)
            
            let pic = URL(string: "\(BaseURL.base)" + imageUrlString)
            
            cell.uploadedImaegView.loadImage(from: pic!, placeHolderImage: UIImage(named: "personal"))
            
            return cell
            
        case .profile :
            cell.countLabel.text = "\(indexPath.row + 1)/\(profileTransitedData.value.image.count ?? 0)"
            
            let url = profileTransitedData.value.image[indexPath.item]
            
            let imageUrlString = "\(url)"
            
            let pic = URL(string: "\(BaseURL.base)" + imageUrlString)
            
            cell.uploadedImaegView.loadImage(from: pic!, placeHolderImage: UIImage(named: "personal"))
            
            return cell
        }
        
    }
    
    
}
