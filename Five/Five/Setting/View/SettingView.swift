//
//  SettingView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/2/23.
//

import UIKit
import SnapKit

class SettingView : BaseView {
    
    let profileImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.image = UIImage(named: "commentProfile")
        return view
    }()
    
    let settingTableView = {
        let view = UITableView()
        view.layer.cornerRadius = 18
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = CustomColor.backgroundColor
        view.separatorStyle = .none
        view.register(SettingTableCell.self, forCellReuseIdentifier: "SettingTableCell")
        view.isScrollEnabled = false
        return view
    }()
    
    let changeButton = {
        let view = UIButton()
        view.layer.cornerRadius = 18
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = CustomColor.backgroundColor
        view.setTitle("개인설정 변경하기", for: .normal)
        view.titleLabel?.font = CustomFont.mediumGmarket15
        view.setTitleColor(.darkGray, for: .normal)
        return view
    }()
    
    let buttonStackView = {
        let view = UIStackView()
        view.distribution = .equalSpacing
        view.axis = .horizontal
        return view
    }()
    
    let logoutButton = {
        let btn = OutButton()
        btn.setTitle("로그아웃", for: .normal)
        return btn
    }()
    
    let seperatorLabel = {
        let view = UILabel()
        view.text = "|"
        view.font = CustomFont.mediumGmarket13
        view.textColor = .systemGray4
        return view
    }()
    
    let withdrawButton = {
        let btn = OutButton()
        btn.setTitle("회원탈퇴", for: .normal)
        return btn
    }()
    
//
    
    
    override func configureView() {
        addSubview(profileImageView)
        addSubview(settingTableView)
        addSubview(changeButton)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(logoutButton)
        buttonStackView.addArrangedSubview(seperatorLabel)
        buttonStackView.addArrangedSubview(withdrawButton)

    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(34)
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(34)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalTo(240)
        }
        
        changeButton.snp.makeConstraints { make in
            make.top.equalTo(settingTableView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalTo(80)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(60)
            make.height.equalTo(17)
            make.horizontalEdges.equalToSuperview().inset(140)
        }

        
    }
    
}
