//
//  FeedCollectionViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 11/26/23.
//

import UIKit
import SnapKit

class FeedCollectionViewCell : BaseCollectionViewCell {
    
    static let identifier = "FeedCollectionViewCell"
    
    let cellBackgroundView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.cornerRadius = 4
        return view
    }()
    
    let profileView = {
        let view = UIView()
        return view
    }()
    
    let profileViewBottomLine = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    let profilePic = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.image = UIImage(systemName: "person.fill")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray2.cgColor
        return view
    }()
    
    let nicknameLabel = {
        let label = UILabel()
        label.font = CustomFont.feedProfile15
        label.textColor = .black
        label.text = "양현종"
        return label
    }()
    
    let moreButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"more")?.withTintColor(.lightGray), for: .normal)
        return btn
    }()
    
    let dummyView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let borderline = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    let elementView = {
        let view = UIView()
        return view
    }()
    
    let fiveButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "five")?.withTintColor(.gray), for: .normal)
        return btn
    }()
    
    let commentButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        btn.tintColor = .gray
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    let dateLabel = {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        label.text = dateFormatter.dateFormat
        label.font = CustomFont.suggestLabel13
        label.textColor = .gray
        return label
    }()
    
    override func configureView() {
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(profileView)
        cellBackgroundView.addSubview(dummyView)
        profileView.addSubview(profilePic)
        profileView.addSubview(nicknameLabel)
        profileView.addSubview(moreButton)
        profileView.addSubview(profileViewBottomLine)
        cellBackgroundView.addSubview(elementView)
        elementView.addSubview(borderline)
        elementView.addSubview(fiveButton)
        elementView.addSubview(commentButton)
        elementView.addSubview(dateLabel)
        
        dummyView.backgroundColor = .systemGray6
    }
    
    override func setConstraints() {
        
        cellBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        profilePic.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.leading.equalTo(profilePic.snp.trailing).offset(16)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(25)
            make.trailing.equalToSuperview().inset(20)
        }
        
        profileViewBottomLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(profileView.snp.bottom)
        }
        
        dummyView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
        borderline.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(dummyView.snp.bottom)
        }
        
        elementView.snp.makeConstraints { make in
            make.top.equalTo(borderline.snp.bottom)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        fiveButton.snp.makeConstraints { make in
            make.size.equalTo(26)
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        commentButton.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.leading.equalTo(fiveButton.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        
    }
    
}
