//
//  ProfileTableViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 12/17/23.
//

import UIKit
import SnapKit

class ProfileFirstCell : BaseTableViewCell {
    
    static let identifier = "ProfileFirstCell"
    
    let profileColorBackgroundView = {
        let view = UIView()
        view.backgroundColor = CustomColor.pointColor?.withAlphaComponent(0.6)
        return view
    }()
    
    let settingButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "setting")?.withRenderingMode(.alwaysTemplate).withTintColor(.white), for: .normal)
        btn.layer.cornerRadius = 16
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemGray4.cgColor
        btn.tintColor = .darkGray
        btn.backgroundColor = CustomColor.backgroundColor
        return btn
    }()
    
    let profileImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 35
        view.layer.borderWidth = 5
        view.layer.borderColor = CustomColor.backgroundColor?.cgColor
        view.image = UIImage(named: "test_profile")
        return view
    }()
    
    let nicknameLabel = {
        let label = UILabel()
        label.text = "양현종"
        label.font = CustomFont.boldGmarket17
        label.textColor = .black
        return label
    }()
    
    let emailImage = {
        let view = UIImageView()
        view.image = UIImage(named: "email.Custom")?.withTintColor(.darkGray)
        return view
    }()
    
    let emailLabel = {
        let label = ProfileLabel()
        label.textColor = .darkGray
        return label
    }()
    
    let followLabel = {
        let label = ProfileLabel()
        label.text = "팔로우"
        label.textColor = .darkGray
        return label
    }()
    
    let followDataLabel = {
        let label = ProfileLabel()
        label.text = "545,454"
        label.textColor = .black
        return label
    }()
    
    let followingLabel = {
        let label = ProfileLabel()
        label.text = "팔로잉"
        label.textColor = .darkGray
        return label
    }()
    
    let followingDataLabel = {
        let label = ProfileLabel()
        label.text = "1,100"
        label.textColor = .black
        return label
    }()
    
    let followButton = {
        let btn = FollowUIButton()
        return btn
    }()
    
    override func configureView() {
        
        contentView.addSubview(profileColorBackgroundView)
        contentView.addSubview(profileImage)
        contentView.addSubview(settingButton)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(emailImage)
        contentView.addSubview(emailLabel)
        contentView.addSubview(followDataLabel)
        contentView.addSubview(followingDataLabel)
        contentView.addSubview(followLabel)
        contentView.addSubview(followingLabel)
        contentView.addSubview(followButton)
    }
    
    override func setConstraints() {
        
        profileColorBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(74)
        }
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.size.equalTo(70)
            make.leading.equalToSuperview().offset(13)
        }
        
        settingButton.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.trailing.equalTo(followButton.snp.leading).offset(-8)
            make.centerY.equalTo(followButton)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(19)
        }
        
        emailImage.snp.makeConstraints { make in
            make.size.equalTo(18)
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalTo(emailImage.snp.trailing).offset(6)
            make.centerY.equalTo(emailImage)
        }
        
        followingDataLabel.snp.makeConstraints { make in
            make.top.equalTo(emailImage.snp.bottom).offset(12)
            make.height.equalTo(14)
            make.leading.equalToSuperview().offset(15)
        }
        
        followingLabel.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.centerY.equalTo(followingDataLabel)
            make.leading.equalTo(followingDataLabel.snp.trailing).offset(4)
        }
        
        
        followDataLabel.snp.makeConstraints { make in
            make.centerY.equalTo(followingDataLabel)
            make.height.equalTo(14)
            make.leading.equalTo(followingLabel.snp.trailing).offset(8)
        }
        
        followLabel.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.centerY.equalTo(followingDataLabel)
            make.leading.equalTo(followDataLabel.snp.trailing).offset(4)
        }
        
        followButton.snp.makeConstraints { make in
            make.top.equalTo(profileColorBackgroundView.snp.bottom).offset(12)
            make.height.equalTo(35)
            make.width.equalTo(90)
            make.trailing.equalToSuperview().inset(13)
        }
        
        
    }
}

