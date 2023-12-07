//
//  SearchCollectionViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 12/7/23.
//

import UIKit
import SnapKit

class SearchTableViewCell : BaseTableViewCell {
    
    private let profileImage = {
        let view = UIImageView()
        view.image = UIImage(named: "test_profile")
        view.layer.cornerRadius = 20
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let stackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        return view
    }()
    
    private let nicknameLabel = {
        let label = UILabel()
        label.text = "The대투수"
        label.font = CustomFont.mediumGmarket15
        label.textColor = .black
        return label
    }()
    
    private let followButton = {
        let btn = FollowUIButton()
        return btn
    }()
    

    
    override func configureView() {
        addSubview(profileImage)
        addSubview(nicknameLabel)
        addSubview(followButton)
    }
    
    override func setConstraints() {
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(13)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
        }
        followButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(13)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(90)

        }
    }
    
    
}
