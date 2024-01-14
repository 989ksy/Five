//
//  SettingViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/2/23.
//

import UIKit
import RxCocoa
import RxSwift

import PhotosUI

final class SettingViewController : BaseViewController {
    
    let mainView = SettingView()
    let menuList = SettingMenu() //메뉴 리스트
    
    //프로필 화면에서 전달받은 값
    var transitedData = MyProfileResponse(posts: [], followers: [], following: [], id: "", email: "", nick: "")
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        
        //네비게이션바
        setNavigation()
        
        //테이블뷰
        mainView.settingTableView.delegate = self
        mainView.settingTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name("needToUpdate"), object: nil)
        
        //키보드설정
        self.hideKeyboardWhenTappedAround()
        
        //바인드
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "개인설정"
    }
    
    
    //MARK: - 프로필 변경하기
    
    func bind() {
        
        //변경하기 버튼
        mainView.changeButton.rx.tap
            .subscribe(with: self) { owner, _ in
                let vc = ChangeSettingViewController()
                
                //닉네임 전달해줄게
                vc.nickname = self.transitedData.nick
                
//                vc.newProfileCompletion! { c in
//                    mainView.profileImageView.image = c
//                }
                
                
                self.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        
        //로그아웃 버튼
        self.mainView.logoutButton.rx.tap
            .subscribe(with: self) { owner, _ in
                let alert = UIAlertController(title: "확인", message: "정말로 로그아웃 하시겠습니까?", preferredStyle: .alert)
                let ok = UIAlertAction(title: "예", style:.default) { _ in
                    
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let SceneDelegate = windowScene?.delegate as? SceneDelegate
                    
                    let vc = LoginViewController()
                    
                    SceneDelegate?.window?.rootViewController = vc
                    SceneDelegate?.window?.makeKeyAndVisible()
                }
                let cancel = UIAlertAction(title: "아니오", style: .cancel)
                
                alert.addAction(cancel)
                alert.addAction(ok)
                
                self.present(alert, animated: true)
                
                
            }
            .disposed(by: self.disposeBag)
        
        
    }
    
    //MARK: - 네비게이션 설정
    func setNavigation() {
        self.title = "개인설정"
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationItem.titleView?.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc
    func reloadTableView() {
        mainView.settingTableView.reloadData()
    }
    
    
}


extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableCell.identifier, for: indexPath) as? SettingTableCell else { return UITableViewCell() }
        
        let data = menuList.list[indexPath.row]
        
        cell.defaultLabel.text = data.label
        
        if indexPath.row == 0 {
            cell.detailLabel.text = transitedData.nick
            print(transitedData.nick)
        } else if indexPath.row == 1 {
            cell.detailLabel.text = transitedData.email
        } else {
            cell.detailLabel.text = "휴대폰 번호 미등록"
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
