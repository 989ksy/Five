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
        view.layer.cornerRadius = 60
        view.layer.borderWidth = 5
        view.layer.borderColor = CustomColor.pointColor?.cgColor
        view.image = UIImage(named: "test_profile")
        return view
    }()
    
    let imageChangeButton = {
        let btn = UIButton()
        btn.setTitle("프로필 사진 바꾸기", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = CustomFont.mediumGmarket15
        btn.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.systemGray4.cgColor
        btn.layer.borderWidth = 1
        return btn
    }()
    
    let plainLine = {
        let view = lineUIView()
        return view
    }()
    
    let nickTitleLabel = {
        let view = UILabel()
        view.text = "닉네임"
        view.font = CustomFont.mediumGmarket15
        view.textColor = .black
        return view
    }()
    
    let nicknameTextField = {
        let txtfield = UITextField()
        txtfield.borderStyle = .none
        txtfield.placeholder = "닉네임을 입력해주세요."
        txtfield.font = CustomFont.mediumGmarket15
        return txtfield
    }()
    
    let nickTxtFieldLine = {
        let view = lineUIView()
        return view
    }()
    
    let plainLine2 = {
        let view = lineUIView()
        return view
    }()
    
    let withdrawButton = {
        let btn = UIButton()
        btn.setTitle("계정 탈퇴하기", for: .normal)
        btn.setTitleColor(.systemGray2, for: .normal)
        btn.titleLabel?.font = CustomFont.mediumGmarket15
        btn.layer.borderColor = UIColor.systemGray4.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    
    override func configureView() {
        addSubview(profileImageView)
        addSubview(imageChangeButton)
        addSubview(plainLine)
        addSubview(nickTitleLabel)
        addSubview(nicknameTextField)
        addSubview(nickTxtFieldLine)
        addSubview(plainLine2)
        addSubview(withdrawButton)
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(27)
            make.size.equalTo(120)
            make.centerX.equalToSuperview()
        }
        
        imageChangeButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.height.equalTo(34)
            make.width.equalTo(140)
        }
        
        plainLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(imageChangeButton.snp.bottom).offset(21)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        nickTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameTextField)
            make.height.equalTo(18)
            make.leading.equalToSuperview().offset(26)
            
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(plainLine.snp.bottom).offset(18)
            make.height.equalTo(34)
            make.leading.equalToSuperview().offset(90)
            make.trailing.equalToSuperview().inset(23)
        }
        
        nickTxtFieldLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalTo(nicknameTextField)
            make.leading.equalToSuperview().offset(90)
            make.trailing.equalToSuperview().inset(23)
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.horizontalEdges.equalToSuperview().inset(8)
//            make.width.equalTo(160) //120
            make.height.equalTo(50)
            
        }
        
    }
    
}
