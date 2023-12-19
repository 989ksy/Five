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
        view.image = UIImage(named: "test_image")
        return view
    }()
    
    let imageChangeButton = {
        let btn = SettingButton()
        btn.layer.borderColor = CustomColor.backgroundColor?.cgColor
        btn.layer.borderWidth = 3
        return btn
    }()
    
    let settingTableView = {
        let view = UITableView()
        view.layer.cornerRadius = 18
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = CustomColor.backgroundColor
        view.separatorStyle = .none
        view.register(SettingTableCell.self, forCellReuseIdentifier: "SettingTableCell")
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
        addSubview(imageChangeButton)
        addSubview(settingTableView)
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
        
        imageChangeButton.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).inset(28)
            make.size.equalTo(32)
            make.bottom.equalTo(profileImageView.snp.bottom).inset(4)
        }
        
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(34)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalTo(240)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(60)
            make.height.equalTo(17)
            make.horizontalEdges.equalToSuperview().inset(140)
        }

        
    }
    
}
