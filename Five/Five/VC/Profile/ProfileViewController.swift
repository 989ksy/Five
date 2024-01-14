//
//  ProfileViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/29/23.
//

import UIKit

import RxSwift
import RxCocoa

import Kingfisher

enum ProfileTransitionType: String {
    case loggedInUser // 로그인한 사용자의 프로필
    case selectedUser // 선택한 사용자의 프로필
}

final class ProfileViewController: BaseViewController {
    
    var type: ProfileTransitionType = .loggedInUser
    var profileImageEndpoint: String?
    
    let mainView = ProfileView()
    let viewModel = ProfileViewModel()
    let headerView = ProfileCollectionHeaderView()

    //FeedVC -> ProfileVC userID ?? userProfile
    var FeedUserId: String?
    var FeedUserProfile: String?
    
    //갱신
    var refresh = PublishSubject<Void>()
    
    let disposeBag = DisposeBag()
    

    override func loadView() {
        self.view = mainView
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //컬렉션뷰
        mainView.fiveCollectionView.dataSource = self
        mainView.fiveCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        //업데이트
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name("needToUpdate"), object: nil)
        
        //작성게시글 조회
        fetchReadData()
        
        headerView.segmentedControl.selectedSegmentIndex = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(segmentValueChanged), name: NSNotification.Name("segmentValueChanged"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name("VCTransited"), object: nil)
        
        //네비게이션 세팅
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        
        bind() //컨텐츠버튼
    }
    
    ///작성게시글 조회
    func fetchReadData() {
        
        switch type {
            
        case .loggedInUser: //내가 작성한 게시글 조회
            viewModel.readData { response in
                switch response {
                case .success(let data):
                    self.viewModel.readMyData = data.data
                    
                    self.profileImageEndpoint = data.data.first?.creator.profile
                    
                    self.mainView.fiveCollectionView.reloadData()
                case .failure(let failure):
                    print("===profile_readData",failure.errorDescription!)
                }
            }
            
        case .selectedUser: //다른 유저 게시글 조회
            
            print("다른 유저 게시글 조회 1")
            
            viewModel.readDataForUser(userID: FeedUserId!) {
                response in
                print("다른유저 게시글 조회2")
                switch response {
                case .success(let data):
                    
                    print("다른 유저 게시글:",data.data)

                    self.viewModel.readUserData = data.data
                    
                    print("데이터 잘 들어감?",self.viewModel.readUserData )
                    self.mainView.fiveCollectionView.reloadData()
                    
                    print("다른유저 게시글 조회 성공3")
                case .failure(let failure):
                    print("===profile_readData",failure.errorDescription!)
                }
            }
        }
        
    }
    
    ///컨텐츠 추가버튼
    func bind() {
        
        let input = ProfileViewModel.Input(addContentTapp: mainView.addContentButton.rx.tap, refresh: refresh, prefetchItem: mainView.fiveCollectionView.rx.prefetchItems)
        
        input.addContentTapp
            .subscribe(with: self) { owner, _ in
                let vc = ContentViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            .disposed(by: disposeBag)

    }

    
    ///세팅버튼 선택 시...
    @objc func settingButtonTapped() {
        let vc = SettingViewController()
        vc.transitedData = viewModel.myProfileData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
  
    //MARK: - SegmentedControl 설정
    
    @objc func segmentValueChanged(_ notification: Notification) {
        guard notification.object is UISegmentedControl else { return }
           mainView.fiveCollectionView.reloadData()
       }
    
    
    @objc func reloadCollectionView() {
        mainView.fiveCollectionView.reloadData()
    }
    
    

}



extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch type {
        case .loggedInUser:
            return viewModel.readMyData.count
            
        case .selectedUser:
            print("=====몇개야..!!",viewModel.readUserData.count)
            print("=====피드에서 넘어옴",viewModel.readUserData)
            return viewModel.readUserData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch type {
        case .loggedInUser:
            
            if  headerView.segmentedControl.selectedSegmentIndex == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiveCollectionViewCell.identifier, for: indexPath) as?  FiveCollectionViewCell else { return UICollectionViewCell() }
                
                let data = viewModel.readMyData[indexPath.item]
                let url = URL(string: "\(BaseURL.base)" + (data.image.first ?? ""))
                cell.firstImageView.loadImage(from: url!, placeHolderImage: UIImage(named: "strar.fill"))
                
                
                if data.image.count < 2 {
                    cell.moreIconImageView.isHidden = true
                } else {
                    cell.moreIconImageView.isHidden = false
                }
                
                
                return cell
                
            } else if headerView.segmentedControl.selectedSegmentIndex == 1 {
                
                NotificationCenter.default.post(name: NSNotification.Name("segmentValueChanged"), object: nil)
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FivedCollectionViewCell.identifier, for: indexPath) as?  FivedCollectionViewCell else { return UICollectionViewCell() }
                
                cell.firstImageView.image = UIImage(systemName: "heart")
                
                return cell
                
            }
            
            return UICollectionViewCell()
            
        case .selectedUser:
            
            if  headerView.segmentedControl.selectedSegmentIndex == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiveCollectionViewCell.identifier, for: indexPath) as?  FiveCollectionViewCell else { return UICollectionViewCell() }
                
                let data = viewModel.readUserData[indexPath.item]
                
                let url = URL(string: "\(BaseURL.base)" + (data.image.first ?? ""))
                cell.firstImageView.loadImage(from: url!, placeHolderImage: UIImage(named: "strar.fill"))
                
                if data.image.count < 2 {
                    cell.moreIconImageView.isHidden = true
                } else {
                    cell.moreIconImageView.isHidden = false
                }
                
                
                
                return cell
                
            } else if headerView.segmentedControl.selectedSegmentIndex == 1 {
                
                NotificationCenter.default.post(name: NSNotification.Name("segmentValueChanged"), object: nil)
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FivedCollectionViewCell.identifier, for: indexPath) as?  FivedCollectionViewCell else { return UICollectionViewCell() }
                
                cell.firstImageView.image = UIImage(systemName: "heart")
                
                return cell
                
            }
            
            return UICollectionViewCell()
            
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch type {
        case .loggedInUser:
            
            let vc = PostViewController()
            vc.profileTransitedData.accept(viewModel.readMyData[indexPath.item])
            vc.type = .profile
            
            navigationController?.pushViewController(vc, animated: true)
            
        case .selectedUser:
            let vc = PostViewController()
            vc.profileTransitedData.accept(viewModel.readUserData[indexPath.item])
            vc.type = .profile
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            
            switch type {
                
            case .loggedInUser:
                
                if kind == UICollectionView.elementKindSectionHeader {
                    
                    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileCollectionHeaderView.identifier, for: indexPath) as? ProfileCollectionHeaderView
                            
                    else {
                        return ProfileCollectionHeaderView()
                    }
                    
                    //HeaderView UI + Layout
                    header.configureView()
                    header.setConstraints()
                    
                    
                    //HeaderView Data ... 통신 성공 시
                    viewModel.fetchMyProfileData { response in
                        switch response {
                        case .success(let data):
                            
                            header.emailLabel.text = data.email
                            header.nicknameLabel.text = data.nick
                            header.followDataLabel.text = "\(data.followers.count)"
                            header.followingDataLabel.text = "\(data.following.count)"
                            
                            if self.profileImageEndpoint != nil {
                                let profileUrl = URL (string: "\(BaseURL.base)" + (self.profileImageEndpoint ?? ""))
                                
                                print("----------🚨",profileUrl)
                                
                                header.profileImage.loadImage(from: profileUrl!, placeHolderImage: UIImage(named: "personal"))
                            } else {
                                header.profileImage.image = UIImage(named: "personal")
                            }

                            if KeychainStorage.shared.userID == self.viewModel.myProfileData.id {
                                header.settingButton.isHidden = false
                                header.followButton.isHidden = true
                            } else {
                                header.settingButton.isHidden = true
                                header.settingButton.isHidden = false
                            }
                            
                            self.viewModel.myProfileData = data
                            
                            ///
                            
                            header.settingButton.addTarget(self, action: #selector(self.settingButtonTapped), for: .touchUpInside)
                            
                                header.segmentedControl.selectedSegmentIndex = 0
                                header.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
                                header.segmentedControl.setTitleTextAttributes(
                                    [
                                        NSAttributedString.Key.foregroundColor: CustomColor.pointColor ?? .systemYellow,
                                        .font: CustomFont.mediumGmarket15 ?? .systemFont(ofSize: 15)
                                    ],
                                    for: .selected
                                )

                        case .failure(let failure):
                            print("myProfile failed",failure.rawValue)
                            print(failure.errorDescription!)
                        }
                    }
                    return header
                    
                } else {
                    return UICollectionReusableView()
                }
                
            case .selectedUser:
                
                if kind == UICollectionView.elementKindSectionHeader {
                    
                    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileCollectionHeaderView.identifier, for: indexPath) as? ProfileCollectionHeaderView
                            
                    else {
                        return ProfileCollectionHeaderView()
                    }
                    
                    //HeaderView UI + Layout
                    header.configureView()
                    header.setConstraints()
                    
                    
                    //HeaderView Data ... 통신 성공 시
                    viewModel.fetchUserProfileData(userID: FeedUserId!) { response in
                        switch response {
                        case .success(let data):
                            
                            header.nicknameLabel.text = data.nick
                            header.followDataLabel.text = "\(data.followers.count)"
                            header.followingDataLabel.text = "\(data.following.count)"
                            
                            if self.FeedUserProfile != nil {
                                let profileURL = URL(string: BaseURL.base + (self.FeedUserProfile ?? ""))
                                header.profileImage.loadImage(from: profileURL!, placeHolderImage: UIImage(named: "personal"))

                            } else {
                                header.profileImage.image = UIImage(named: "personal")
                            }
                            
    
                            //self.viewModel.myProfileData.id
                            
                            if KeychainStorage.shared.userID == data.id
                            {
                                header.settingButton.isHidden = false
                                header.followButton.isHidden = true
                                header.emailLabel.text = KeychainStorage.shared.userEmail//"yeah@gmail.com"
                            } else {
                                header.settingButton.isHidden = true
                                header.followButton.isHidden = false
                                header.emailLabel.text = "wow@gmail.com"
                            }
                            
                            self.viewModel.userProfileData = data
                            
                            header.settingButton.addTarget(self, action: #selector(self.settingButtonTapped), for: .touchUpInside)
                            
                                header.segmentedControl.selectedSegmentIndex = 0
                                header.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
                                header.segmentedControl.setTitleTextAttributes(
                                    [
                                        NSAttributedString.Key.foregroundColor: CustomColor.pointColor ?? .systemYellow,
                                        .font: CustomFont.mediumGmarket15 ?? .systemFont(ofSize: 15)
                                    ],
                                    for: .selected
                                )

                        case .failure(let failure):
                            print("myProfile failed",failure.rawValue)
                            print(failure.errorDescription!)
                        }
                    }
                    return header
                    
                } else {
                    return UICollectionReusableView()
                }
                
            }
            
           
        }
        
        
}
