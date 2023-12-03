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
    
    var contentButtonTappedAction : (() -> Void)?
    
    //MARK: - 큰틀
    
    let cellBackgroundView = {
        let view = UIView()
        view.layer.borderWidth = 1.1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.cornerRadius = 4
        return view
    }()
    
    //MARK: - 프로필 + 이름 + 메뉴
    let profileView = {
        let view = UIView()
        return view
    }()
    
    let profileViewBottomLine = {
        let view = UIView()
        view.layer.borderWidth = 1.1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    let profilePic = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.image = UIImage(systemName: "person.fill")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.layer.borderWidth = 1.1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    let nicknameLabel = {
        let label = UILabel()
        label.font = CustomFont.mediumGmarket15
        label.textColor = .black
        label.text = "양현종"
        return label
    }()
    
    let moreButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"more")?.withTintColor(.gray), for: .normal)
        return btn
    }()
    
    //MARK: - 이미지영역
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let borderline = {
        let view = UIView()
        view.layer.borderWidth = 1.1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    let elementView = {
        let view = UIView()
        return view
    }()
    
    let fiveButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "five")?.withTintColor(.black), for: .normal)
        return btn
    }()
    
    let commentButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "comment")?.withTintColor(.black), for: .normal)
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    let contentButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "content")?.withTintColor(.black), for: .normal)
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    let dateLabel = {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        label.text = dateFormatter.dateFormat
        label.font = CustomFont.lightGmarket11
        label.textColor = .darkGray
        return label
    }()
    
    override func configureView() {
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(profileView)
        cellBackgroundView.addSubview(imageView)
        profileView.addSubview(profilePic)
        profileView.addSubview(nicknameLabel)
        profileView.addSubview(moreButton)
        profileView.addSubview(profileViewBottomLine)
        cellBackgroundView.addSubview(elementView)
        elementView.addSubview(borderline)
        elementView.addSubview(fiveButton)
        elementView.addSubview(commentButton)
        elementView.addSubview(contentButton)
        elementView.addSubview(dateLabel)
        
        imageView.backgroundColor = .systemGray6
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
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(36)
            make.centerY.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.leading.equalTo(profilePic.snp.trailing).offset(16)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(17)
            make.trailing.equalToSuperview().inset(10)
        }
        
        profileViewBottomLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(profileView.snp.bottom)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(230)
        }
        
        borderline.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
        }
        
        elementView.snp.makeConstraints { make in
            make.top.equalTo(borderline.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(36)
        }
        
        fiveButton.snp.makeConstraints { make in
            make.size.equalTo(26)
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
        
        commentButton.snp.makeConstraints { make in
            make.size.equalTo(26)
            make.leading.equalTo(fiveButton.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
        
        contentButton.snp.makeConstraints { make in
            make.size.equalTo(23)
            make.leading.equalTo(commentButton.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }

        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        
    }
    
}
