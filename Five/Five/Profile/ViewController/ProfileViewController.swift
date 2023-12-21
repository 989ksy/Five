//
//  ProfileViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/29/23.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    let headerView = ProfileCollectionHeaderView()
    var profileData : MyProfileResponse = MyProfileResponse(posts: [], followers: [], following: [], id: "", email: "", nick: "")
    
    let viewModel = ProfileViewModel()

    var refresh = PublishSubject<Void>()
    
    let disposeBag = DisposeBag()
    
    
    
    //MARK: - SegmentedControl 설정
    
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            mainView.fiveCollectionView.isHidden = shouldHideFirstView
            mainView.fivedView.isHidden = !self.mainView.fiveCollectionView.isHidden
        }
    }
    
    
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
    
    func setSegmentedControl() {
        
        headerView.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment: )), for: .valueChanged)
        headerView.segmentedControl.selectedSegmentIndex = 0
        headerView.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        headerView.segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: CustomColor.pointColor ?? .systemYellow,
                .font: CustomFont.mediumGmarket15 ?? .systemFont(ofSize: 15)
            ],
            for: .selected
        )
        headerView.segmentedControl.selectedSegmentIndex = 0
        
    }

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
//        NotificationCenter.default.addObserver(self, selector: #selector(uploadView), name: NSNotification.Name("needToUpdate"), object: nil)
        
        setSegmentedControl()
        fetchReadData()
        
        bind() //컨텐츠버튼
    }
    
    func fetchReadData() {
        
        viewModel.readData { response in
            switch response {
            case .success(let data):
                self.viewModel.data = data.data
                self.mainView.fiveCollectionView.reloadData()
            case .failure(let failure):
                print("===profile_readData",failure.errorDescription!)
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
        vc.transitedData = profileData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}



extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiveCollectionViewCell.identifier, for: indexPath) as?  FiveCollectionViewCell else { return UICollectionViewCell() }
        
        let data = viewModel.data[indexPath.item]
        
        let url = URL(string: "\(BaseURL.base)" + (data.image.first ?? ""))
        cell.firstImageView.loadImage(from: url!, placeHolderImage: UIImage(named: "strar.fill"))
        
        if data.image.count < 2 {
            cell.moreIconImageView.isHidden = true
        } else {
            cell.moreIconImageView.isHidden = false
        }
            return cell
        
    }
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            
            if kind == UICollectionView.elementKindSectionHeader {
                
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileCollectionHeaderView.identifier, for: indexPath) as? ProfileCollectionHeaderView
                        
                else {
                    return ProfileCollectionHeaderView()
                }
                
                //HeaderView UI + Layout
                header.configureView()
                header.setConstraints()
                
                //HeaderView Data ... 통신 성공 시
                viewModel.fetchData { response in
                    switch response {
                    case .success(let data):
                        
                        header.emailLabel.text = data.email
                        header.nicknameLabel.text = data.nick
                        header.followDataLabel.text = "\(data.followers.count)"
                        header.followingDataLabel.text = "\(data.following.count)"
                        
                        self.profileData = data
                        
                        header.settingButton.addTarget(self, action: #selector(self.settingButtonTapped), for: .touchUpInside)
                        
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
