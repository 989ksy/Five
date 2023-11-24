//
//  PasswordView.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit

class PasswordView : BaseView {
    
    let guideLabel = {
        let view = UILabel()
        view.text = "로그인에 사용할\n비밀번호를 입력해주세요."
        view.font = Font.guideLabel18
        view.numberOfLines = 0
        return view
    }()
    
    //MARK: 진행률
    let progressStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.layer.borderWidth = 1
        view.layer.borderColor = Color.pointColor?.cgColor
        view.layer.cornerRadius = 3
        return view
    }()
    
    let emailView = {
        let view = UIView()
        view.backgroundColor = Color.pointColor
        view.layer.cornerRadius = 3
        return view
    }()
    let passwordView = {
        let view = UIView()
        view.backgroundColor = Color.pointColor
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
    
    let passwordTextfield = {
        let view = UITextField()
        view.placeholder = "비밀번호 입력"
        view.font = Font.textfield15
        view.borderStyle = .roundedRect
        return view
    }()
    
    let firstDirectionLabel = {
        let view = UILabel()
        view.font = Font.suggestLabel13
        view.textColor = .lightGray
        return view
    }()
    
    let checkPasswordTextfield = {
        let view = UITextField()
        view.placeholder = "비밀번호 확인"
        view.font = Font.textfield15
        view.borderStyle = .roundedRect
        return view
    }()
    
    let secondDirectionLabel = {
        let view = UILabel()
        view.font = Font.suggestLabel13
        view.textColor = .lightGray
        return view
    }()
    
    let nextButton = {
        let view = UIButton()
        view.setTitle("다음", for: .normal)
        view.backgroundColor = .black
        view.layer.cornerRadius = 15
        view.titleLabel?.font = Font.textfield15
        return view
    }()
    
    
    override func configureView() {
        
        addSubview(guideLabel)
        addSubview(progressStackView)
        progressStackView.addArrangedSubview(emailView)
        progressStackView.addArrangedSubview(passwordView)
//        progressStackView.addArrangedSubview(birthdayView)
        progressStackView.addArrangedSubview(nicknameView)
        addSubview(passwordTextfield)
        addSubview(firstDirectionLabel)
        addSubview(checkPasswordTextfield)
        addSubview(secondDirectionLabel)
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
        
        passwordTextfield.snp.makeConstraints{
            $0.top.equalTo(progressStackView.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        
        firstDirectionLabel.snp.makeConstraints{
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(15)
        }
        
        checkPasswordTextfield.snp.makeConstraints{
            $0.top.equalTo(firstDirectionLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        
        secondDirectionLabel.snp.makeConstraints{
            $0.top.equalTo(checkPasswordTextfield.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(15)
        }
        
        nextButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(secondDirectionLabel.snp.bottom).offset(20)
        }
        
    }
    
}

