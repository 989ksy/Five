//
//  SettingViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/2/23.
//

import UIKit
import RxCocoa
import RxSwift

final class SettingViewController : BaseViewController {
    
    let mainView = SettingView()
    let menuList = SettingMenu()

    var transitedData = BehaviorRelay(value: [MyProfileResponse(posts: [], followers: [], following: [], id: "", email: "", nick: "")])
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        
        setNavigation()
        
        mainView.settingTableView.delegate = self
        mainView.settingTableView.dataSource = self

        self.hideKeyboardWhenTappedAround()
        setting()
    }
    
    
    func setNavigation() {
        self.title = "개인설정"
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationItem.titleView?.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setting() {
//        mainView.nicknameTextField.text = transitedData.value.first?.nick
    }
    
}


extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableCell.identifier, for: indexPath) as? SettingTableCell else { return UITableViewCell() }
        cell.backgroundColor = CustomColor.backgroundColor
        cell.layer.borderColor = UIColor.systemGray5.cgColor
        cell.layer.borderWidth = 0.5
        
        let data = menuList.list[indexPath.row]
        
        cell.defaultLabel.text = data.label
        
        if indexPath.row == 0 {
            cell.detailLabel.text = transitedData.value.first?.nick
        } else if indexPath.row == 1 {
            cell.detailLabel.text = transitedData.value.first?.email
        } else {
            cell.detailLabel.text = "휴대폰 번호 미등록"
        }

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    
    
}
