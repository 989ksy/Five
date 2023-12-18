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
    
    override func configureView() {
        
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(commentLabel)
        
        contentView.backgroundColor = CustomColor.backgroundColor
        
    }
    
    override func setConstraints() {
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(14)
            make.height.equalTo(15)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(8)
        }
        
        
    }
    
    
    
}
