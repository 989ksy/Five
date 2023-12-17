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
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.ProfiletableView.dataSource = self
        mainView.ProfiletableView.delegate = self
        
        //        navigationController?.navigationBar.isHidden = true
        
        profileNetwork()
        
    }
    
    ///네트워크 통신
    ///성공 시 내프로필 조회값을 profileData에 넣어줌
    func profileNetwork() {
        
        viewModel.fetchData { [self] result in
            switch result {
            case .success(let data):
                viewModel.profileData = [data]
                mainView.ProfiletableView.reloadData()
                print(data)
            case .failure(let failure):
                print(failure)
            }
        }
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
            
            cell.nicknameLabel.text = viewModel.profileData.first?.nick
            cell.emailLabel.text = viewModel.profileData.first?.email
            cell.settingButton.addTarget(self, action: #selector(settingButonTapped), for: .touchUpInside)
            cell.followDataLabel.text = "\(viewModel.profileData.first?.followers.count ?? 555)"
            cell.followingDataLabel.text = "\(viewModel.profileData.first?.following.count ?? 666)"
            
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
        //        self.present(vc, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

