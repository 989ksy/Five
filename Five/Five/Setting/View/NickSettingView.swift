//
//  NickSettingView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/20/23.
//

import UIKit
import SnapKit

class NickSettingView: BaseView {
    
    let borderLine1 = {
        let view = LineView()
        return view
    }()
    let directionLabel = {
        let label = UILabel()
        label.font = CustomFont.mediumGmarket15
        label.textColor = .black
        label.text = "새로운 닉네임을 입력해주세요"
        return label
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
        btn.titleLabel?.font = CustomFont.mediumGmarket15
        return btn
    }()
    
    override func configureView() {
       addSubview(borderLine1)
        addSubview(directionLabel)
        addSubview(nicknameTextfield)
        addSubview(borderLine2)
        addSubview(doneButton)
    }
    
    override func setConstraints() {
        
        borderLine1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        directionLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(26)
            make.leading.equalToSuperview().inset(15)
            make.height.equalTo(17)
        }
        
        nicknameTextfield.snp.makeConstraints { make in
            make.top.equalTo(directionLabel.snp.bottom).offset(14)
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
