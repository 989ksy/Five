//
//  LoginView.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import SnapKit

final class LoginView : BaseView {
    
    let titleLabel = {
        let view = UILabel()
        view.text = "FIVE"
        view.font = CustomFont.logo33
        view.textColor = CustomColor.pointColor
        return view
    }()
    
    let emailTextField = {
        let view = UITextField()
        view.placeholder = "이메일을 입력해주세요."
        view.borderStyle = .none
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.font = CustomFont.lightGmarket15
        view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        return view
    }()
    
    let passwordTextField = {
        let view = UITextField()
        view.placeholder = "비밀번호를 입력해주세요."
        view.borderStyle = .none
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.font = CustomFont.lightGmarket15
        view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        view.leftViewMode = .always
        view.autocapitalizationType = .none
        view.isSecureTextEntry = true
        return view
    }()
    
    let eyeButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "EyeOn")?.withTintColor(.systemGray2), for: .normal)
        return btn
    }()
    
    let loginButton = {
        let view = UIButton()
        view.setTitle("로그인하기", for: .normal)
        view.backgroundColor = CustomColor.pointColor
        view.layer.cornerRadius = 10
        view.titleLabel?.font = CustomFont.lightGmarket15
        return view
    }()
    
    let joinStackView = {
        let view = UIStackView()
        view.distribution = .equalSpacing
        return view
    }()
    
    let askJoinLabel = {
        let view = UILabel()
        view.text = "회원이 아니신가요?"
        view.font = CustomFont.lightGmarket13
        view.textColor = .gray
        return view
    }()
    
    let joinButton = {
        let view = UIButton()
        view.setTitle("회원가입", for: .normal)
        view.titleLabel?.font = UIFont(name: "GmarketSansTTFMedium", size: 13)
        view.setTitleColor(.darkGray, for: .normal)
        return view
    }()
    
    override func configureView() {
        
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(eyeButton)
        addSubview(loginButton)
        addSubview(joinStackView)
        joinStackView.addArrangedSubview(askJoinLabel)
        joinStackView.addArrangedSubview(joinButton)
        
    }
    
    override func setConstraints() {
        
        titleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.height.equalTo(34)
            $0.top.equalTo(safeAreaLayoutGuide).offset(40)
        }
        
        emailTextField.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(emailTextField.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        eyeButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.trailing.equalTo(passwordTextField.snp.trailing ).inset(8)
            make.centerY.equalTo(passwordTextField)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        joinStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
            $0.top.equalTo(loginButton.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(112)
        }
        
        
    }
    
}
