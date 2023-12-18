//
//  commentTableViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 12/18/23.
//

import UIKit
import SnapKit

class CommentTableViewCell : BaseTableViewCell {
    
    static let identifier = "CommentTableViewCell"
    
    let profileImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "commentProfile")
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 13
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    let nicknameLabel = {
        let view = UILabel()
        view.font = CustomFont.mediumGmarket14
        view.text = "닉네임자리"
        view.numberOfLines = 0
        view.textColor = .black
        return view
    }()
    
    let commentLabel = {
        let view = UILabel()
        view.text = "이야 대박이다!"
        view.font = CustomFont.lightGmarket13
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nicknameLabel.text = nil
        commentLabel.text = nil
    }
    
    override func configureView() {
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(commentLabel)
        
        contentView.backgroundColor = CustomColor.backgroundColor
        
    }
    
    override func setConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(26)
            make.leading.equalToSuperview().offset(18)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.height.equalTo(15)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(8)
        }
        
        
    }
    
    
    
}
