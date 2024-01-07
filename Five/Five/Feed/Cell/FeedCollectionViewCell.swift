//
//  FeedCollectionViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 11/26/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FeedCollectionViewCell : BaseCollectionViewCell {
    
    static let identifier = "FeedCollectionViewCell"
    var disposeBag = DisposeBag()
    
    var likeStatus : Bool?
    
    //MARK: - 프로필 + 이름 + 메뉴
    
    let profileView = {
        let view = UIView()
        return view
    }()
    
    let profileViewBottomLine = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    let profilePic = {
        let view = ProfileImageView(frame: .zero)
        return view
    }()
    
    let nickLabel = {
        let label = NicknameLabel()
        return label
    }()
    
    let nicknameButton = {
        let btn = UIButton()
        return btn
    }()
    
    let optionButton = {
        let btn = MoreButton()
        return btn
    }()
    
    //MARK: - 이미지영역
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = CustomColor.backgroundColor
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let borderline = {
        let view = UIView()
        view.layer.borderWidth = 1.1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    //MARK: - 버튼 영역
    
    let elementView = {
        let view = UIView()
        return view
    }()
    
    let fiveButton = {
        let btn = FiveButton()
        return btn
    }()
    
    let commentButton = {
        let btn = CommentButton()
        return btn
    }()
    
    let shareButton = {
        let btn = ShareButton()
        return btn
    }()
    
    let dateLabel = {
        let label = DateLabel()
        return label
    }()
    
    //MARK: - 셀 재사용
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        likeStatus = nil
    }
    
    
    override func configureView() {
        
        contentView.addSubview(profileView)
        contentView.addSubview(imageView)
        profileView.addSubview(profilePic)
        profileView.addSubview(nickLabel)
        profileView.addSubview(nicknameButton)
        profileView.addSubview(profileViewBottomLine)
        contentView.addSubview(elementView)
        elementView.addSubview(borderline)
        elementView.addSubview(fiveButton)
        elementView.addSubview(commentButton)
        elementView.addSubview(shareButton)
        elementView.addSubview(dateLabel)
        
    }
    
    override func setConstraints() {

        profileView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        profilePic.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        nickLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.leading.equalTo(profilePic.snp.trailing).offset(12)
        }
        
        nicknameButton.snp.makeConstraints { make in
            make.edges.equalTo(profileView)
        }
        
        profileViewBottomLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(profileView.snp.bottom)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(elementView.snp.top)
        }
        
        borderline.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
        }
        
        elementView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
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
        
        shareButton.snp.makeConstraints { make in
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
