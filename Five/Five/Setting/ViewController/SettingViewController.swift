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
        
        mainView.changeButton.rx.tap
            .subscribe(with: self) { owner, _ in
                let vc = ChangeSettingViewController()
                self.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    //MARK: - 네비게이션 설정
    func setNavigation() {
        self.title = "개인설정"
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationItem.titleView?.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let vc = ChangeSettingViewController()
//            vc.nickname = transitedData.value.nick
//            vc.newNicknameCompletion = { [weak self] name in
//                
//                var updatedData = self?.transitedData.value
//                updatedData?.nick = name
//                self?.transitedData.accept(updatedData!)
//                self?.mainView.settingTableView.reloadData()
//                print("+++++", name)
//            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
