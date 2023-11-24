//
//  EmailView.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import SnapKit

class EmailView : BaseView {
    
    //MARK: - 가이드
    
    let guideLabel = {
        let view = UILabel()
        view.text = "로그인에 사용할\n이메일을 입력해주세요."
        view.font = CustomFont.guideLabel18
        view.numberOfLines = 0
        return view
    }()
    
    //MARK: 진행률
    let progressStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.layer.borderWidth = 1
        view.layer.borderColor = CustomColor.pointColor?.cgColor// UIColor.darkGray.cgColor
        view.layer.cornerRadius = 3
        return view
    }()
    
    let emailView = {
        let view = UIView()
        view.backgroundColor = CustomColor.pointColor
        view.layer.cornerRadius = 3
        return view
    }()
    let passwordView = {
        let view = UIView()
        return view
    }()
//    let birthdayView = {
//        let view = UIView()
//        return view
//    }()
    let nicknameView = {
        let view = UIView()
        return view
    }()
    
    //MARK: - 입력창 + 버튼
    
    let emailTextfield = {
        let view = UITextField()
        view.placeholder = "이메일 입력"
        view.font = CustomFont.textfield15
        view.borderStyle = .roundedRect
        return view
    }()
    
    let directionLabel = {
        let view = UILabel()
        view.font = CustomFont.suggestLabel13
        view.textColor = .gray
        return view
    }()
    
    let nextButton = {
        let view = UIButton()
        view.setTitle("다음", for: .normal)
        view.backgroundColor = .black
        view.layer.cornerRadius = 15
        view.titleLabel?.font = CustomFont.textfield15
        return view
    }()
    
    //MARK: - configure
    
    override func configureView() {
        addSubview(guideLabel)
        addSubview(progressStackView)
        progressStackView.addArrangedSubview(emailView)
        progressStackView.addArrangedSubview(passwordView)
//        progressStackView.addArrangedSubview(birthdayView)
        progressStackView.addArrangedSubview(nicknameView)
        addSubview(emailTextfield)
        addSubview(directionLabel)
        addSubview(nextButton)
    }
    
    override func setConstraints() {
        guideLabel.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.height.lessThanOrEqualTo(60)
        }
        
        progressStackView.snp.makeConstraints{
            $0.top.equalTo(guideLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(10)
        }
        
        emailTextfield.snp.makeConstraints{
            $0.top.equalTo(progressStackView.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        
        directionLabel.snp.makeConstraints{
            $0.top.equalTo(emailTextfield.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(15)
        }
        
        nextButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(directionLabel.snp.bottom).offset(20)
        }
        
    }
    
    
}

