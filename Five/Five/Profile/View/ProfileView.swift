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
        btn.layer.borderColor = CustomColor.backgroundColor?.cgColor
        btn.tintColor = .darkGray
        btn.backgroundColor = CustomColor.backgroundColor
        return btn
    }()
    
    let profileImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 45
        view.layer.borderWidth = 5
        view.layer.borderColor = CustomColor.backgroundColor?.cgColor
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
    
    let segmentedControl = {
        let control = UnderlineSegmentedControl(items: ["Five","Fived"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let fiveView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let fivedView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func configureView() {
        addSubview(backgroundView)
        addSubview(profileImage)
        addSubview(settingButton)
        addSubview(nicknameLabel)
        addSubview(followLabel)
        addSubview(followingLabel)
        addSubview(followDataLabel)
        addSubview(followingDataLabel)
        addSubview(followButton)
        addSubview(segmentedControl)
        addSubview(fivedView)
        addSubview(fiveView)
    }
    
    override func setConstraints() {
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(130)
        }
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(90)
            make.centerX.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints { make in
            make.size.equalTo(32)
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
            make.top.equalTo(nicknameLabel.snp.bottom).offset(12)
            make.height.equalTo(35)
            make.width.equalTo(90)
            make.centerX.equalTo(profileImage)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(followButton.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(120)
            make.height.equalTo(40)
        }
        
        fiveView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        fivedView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
}
