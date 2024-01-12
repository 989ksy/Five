//
//  NicknameView.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit

class NicknameView : BaseView {
    
    //MARK: - 가이드
    
    let guideLabel = {
        let view = UILabel()
        view.text = "사용하실\n이름을 입력해주세요."
        view.font = CustomFont.mediumGmarket18
        view.numberOfLines = 0
        return view
    }()
    
    //MARK: 진행률
    let progressStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.layer.borderWidth = 1
        view.layer.borderColor = CustomColor.pointColor?.cgColor
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
        view.backgroundColor = CustomColor.pointColor
        return view
    }()
//    let birthdayView = {
//        let view = UIView()
//        view.backgroundColor = Color.pointColor
//        return view
//    }()
    let nicknameView = {
        let view = UIView()
        view.backgroundColor = CustomColor.pointColor
        view.layer.cornerRadius = 3
        return view
    }()
    
    //MARK: - 입력창 + 버튼
    
    let nicknameTextfield = {
        let view = UITextField()
        view.placeholder = "닉네임 입력"
        view.font = CustomFont.lightGmarket15
        view.borderStyle = .roundedRect
        return view
    }()
    
    let directionLabel = {
        let view = UILabel()
        view.font = CustomFont.lightGmarket13
        view.textColor = .gray
        return view
    }()
    
    let nextButton = {
        let view = UIButton()
        view.setTitle("가입하기", for: .normal)
        view.backgroundColor = .black
        view.layer.cornerRadius = 15
        view.titleLabel?.font = CustomFont.lightGmarket15
        return view
    }()
    
    override func configureView() {
        addSubview(guideLabel)
        addSubview(progressStackView)
        progressStackView.addArrangedSubview(emailView)
        progressStackView.addArrangedSubview(passwordView)
//        progressStackView.addArrangedSubview(birthdayView)
        progressStackView.addArrangedSubview(nicknameView)
        addSubview(nicknameTextfield)
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
        
        nicknameTextfield.snp.makeConstraints{
            $0.top.equalTo(progressStackView.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        
        directionLabel.snp.makeConstraints{
            $0.top.equalTo(nicknameTextfield.snp.bottom).offset(12)
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

