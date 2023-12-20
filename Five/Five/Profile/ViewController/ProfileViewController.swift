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
    let viewModel = ProfileViewModel()
    
    var refresh = PublishSubject<Void>()
    
    let disposeBag = DisposeBag()
    
    //리프레싱 컨트롤 생성
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshingData), for: .valueChanged)
        return refreshControl
        
    }()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        //테이블뷰
        mainView.profiletableView.dataSource = self
        mainView.profiletableView.delegate = self
        
        //리프레싱
        mainView.profiletableView.refreshControl = refreshControl
        
        //업데이트
        NotificationCenter.default.addObserver(self, selector: #selector(uploadView), name: NSNotification.Name("needToUpdate"), object: nil)
        
        profileNetwork() //프로필조회
        bind() //컨텐츠버튼
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    ///네트워크 통신
    ///성공 시 내프로필 조회값을 profileData에 넣어줌
    func profileNetwork() {
        
        viewModel.fetchData { [self] result in
            switch result {
            case .success(let data):
                viewModel.profileData = data
                mainView.profiletableView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
    ///컨텐츠 추가버튼
    func bind() {
        
        let input = ProfileViewModel.Input(addContentTapp: mainView.addContentButton.rx.tap, refresh: refresh)
        
        input.addContentTapp
            .subscribe(with: self) { owner, _ in
                let vc = ContentViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .subscribe(with: self) { owner, _ in
                owner.mainView.profiletableView.reloadData()
                owner.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
    }
    
    
    //MARK: - 새 포스트 갱신
    
    @objc func uploadView() {
        refresh.onNext(Void())
    }
    
    
    //MARK: - 화면 로딩
    
    @objc private func refreshingData() {
        refreshControl.endRefreshing()
        refresh.onNext(Void())
    }
    
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1{
            return 1
        }
        
        return 0
    }
    
    ///셀 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFirstCell", for: indexPath) as? ProfileFirstCell else {return UITableViewCell()}
            
            cell.nicknameLabel.text = viewModel.profileData.nick
            cell.emailLabel.text = viewModel.profileData.email
            cell.settingButton.addTarget(self, action: #selector(settingButonTapped), for: .touchUpInside)
            cell.followDataLabel.text = "\(viewModel.profileData.followers.count )"
            cell.followingDataLabel.text = "\(viewModel.profileData.following.count)"
            
//            if viewModel.profileData.first?.id != KeychainStorage.shared.userID {
//                cell.settingButton.isHidden = true
//            }
            
            return cell
            
        } else if indexPath.section == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSecondCell", for: indexPath) as? ProfileSecondCell else {return UITableViewCell()}

            return cell
        }
        return UITableViewCell()
    }
    
    ///섹션별 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 200
            
        } else if indexPath.section == 1 {
            
            let rectForSection0 = tableView.rect(forSection: 0)
            let remainingHeight = tableView.bounds.height - rectForSection0.origin.y - rectForSection0.height
            
            return remainingHeight
        }
        
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //선택 시 회색셀렉션 제거
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    
    ///설정버튼 눌렀을 때
    @objc func settingButonTapped() {
        let vc = SettingViewController()
        vc.transitedData.accept(viewModel.profileData)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
}

