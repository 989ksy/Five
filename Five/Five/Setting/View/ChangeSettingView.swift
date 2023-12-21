//
//  NickSettingView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/20/23.
//

import UIKit
import SnapKit

class ChangeSettingView: BaseView {
    
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
    
    let imageChangeButton = {
        let btn = SettingButton()
        btn.layer.borderColor = CustomColor.backgroundColor?.cgColor
        btn.layer.borderWidth = 3
        return btn
    }()
    
    
    let nicknameTextfield = {
        let field = UITextField()
        field.layer.cornerRadius = 5
        field.layer.borderColor = UIColor.systemGray4.cgColor
        field.layer.borderWidth = 1
        field.font = CustomFont.mediumGmarket14
        field.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        field.leftViewMode = .always
        return field
    }()
    
    let borderLine2 = {
        let view = LineView()
        return view
    }()
    let doneButton = {
        let btn = UIButton()
        btn.setTitle("변경 완료", for: .normal)
        btn.backgroundColor = CustomColor.pointColor
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = CustomFont.lightGmarket15
        return btn
    }()
    
    override func configureView() {
        addSubview(profileImageView)
        addSubview(imageChangeButton)
        addSubview(nicknameTextfield)
        addSubview(borderLine2)
        addSubview(doneButton)
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
        
        nicknameTextfield.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(38)
        }
        
        borderLine2.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-140)
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(borderLine2.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalTo(60)
            
        }
        
    }
    
}
