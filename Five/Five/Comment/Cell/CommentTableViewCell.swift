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
    
    let dateLabel = {
        let view = UILabel()
        view.font = CustomFont.mediumGmarket12
        view.textColor = .lightGray
        return view
    }()
    
    let writerLabel = {
        let view = UILabel()
        view.text = "· 작성자"
        view.font = CustomFont.mediumGmarket13
        view.textColor = .darkGray
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nicknameLabel.text = nil
        commentLabel.text = nil
        dateLabel.text = nil
    }
    
    override func configureView() {
        
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(writerLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)
        
        contentView.backgroundColor = CustomColor.backgroundColor
        
    }
    
    override func setConstraints() {
        
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.height.equalTo(15)
        }
        
        writerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(6)
            make.height.equalTo(15)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.bottom.equalTo(contentView.snp.bottom).inset(4)
//            make.height.greaterThanOrEqualTo(30)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameLabel)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(15)
        }
        
    }
    
    
    
}
