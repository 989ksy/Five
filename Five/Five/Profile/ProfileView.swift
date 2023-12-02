//
//  ProfileView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit
import SnapKit

class ProfileView : BaseView {
    
    let backgroundView = {
        let view = UIView()
        view.backgroundColor = CustomColor.pointColor?.withAlphaComponent(0.6)
        return view
    }()
    
    let settingButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "setting")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.layer.cornerRadius = 18
        btn.layer.borderWidth = 5
        btn.layer.borderColor = UIColor.white.cgColor
        btn.tintColor = .darkGray
        btn.backgroundColor = .white
        return btn
    }()
    
    let profileImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 60
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.white.cgColor
        view.image = UIImage(named: "test_profile")
        return view
    }()
    
    let nicknameLabel = {
        let label = UILabel()
        label.text = "The대투수"
        label.font = CustomFont.boldGmarket20
        label.textColor = .black
        return label
    }()
    
    let followLabel = {
        let label = UILabel()
        label.text = "팔로우"
        label.font = CustomFont.lightGmarket15
        label.textColor = .black
        return label
    }()
    
    let followDataLabel = {
        let label = UILabel()
        label.text = "545,454"
        label.font = CustomFont.mediumGmarket17
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let followingLabel = {
        let label = UILabel()
        label.text = "팔로잉"
        label.font = CustomFont.lightGmarket15
        label.textColor = .black
        return label
    }()
    
    let followingDataLabel = {
        let label = UILabel()
        label.text = "1,100"
        label.font = CustomFont.mediumGmarket17
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let followButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 6
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemGray4.cgColor
        btn.titleLabel?.font = CustomFont.mediumGmarket15
        btn.setTitleColor(.darkGray, for: .normal)
        btn.setTitle("팔로우하기", for: .normal)
        return btn
    }()
    
    
    override func configureView() {
        addSubview(backgroundView)
        addSubview(profileImage)
        profileImage.backgroundColor = .black
        addSubview(settingButton)
        addSubview(nicknameLabel)
        addSubview(followLabel)
        addSubview(followingLabel)
        addSubview(followDataLabel)
        addSubview(followingDataLabel)
        addSubview(followButton)
    }
    
    override func setConstraints() {
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(164)
        }
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(120)
            make.centerX.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.leading.equalTo(profileImage.snp.trailing).inset(30)
            make.top.equalTo(backgroundView.snp.bottom).offset(10)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        
        followingDataLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView.snp.bottom).offset(-12)
            make.height.equalTo(18)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(profileImage.snp.leading).offset(-4)
        }
        
        followingLabel.snp.makeConstraints { make in
            make.bottom.equalTo(followingDataLabel.snp.top).offset(-8)
            make.height.equalTo(15)
            make.centerX.equalTo(followingDataLabel)
        }
        
        followDataLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView.snp.bottom).offset(-12)
            make.height.equalTo(18)
            make.trailing.equalToSuperview().offset(-4)
            make.leading.equalTo(profileImage.snp.trailing).offset(4)
        }
        
        followLabel.snp.makeConstraints { make in
            make.bottom.equalTo(followDataLabel.snp.top).offset(-8)
            make.height.equalTo(15)
            make.centerX.equalTo(followDataLabel)
        }
        
        followButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(38)
            make.width.equalTo(90)
        }
        
    }
    
}