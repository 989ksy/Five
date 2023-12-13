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
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let imageCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = CustomColor.backgroundColor
        view.isPagingEnabled = true
        return view
    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }
    
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
        
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureView() {
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(profileView)
        cellBackgroundView.addSubview(imageView)
        profileView.addSubview(profilePic)
        profileView.addSubview(nickLabel)
        profileView.addSubview(nicknameButton)
        profileView.addSubview(optionButton)
        profileView.addSubview(profileViewBottomLine)
        cellBackgroundView.addSubview(elementView)
        elementView.addSubview(borderline)
        elementView.addSubview(fiveButton)
        elementView.addSubview(commentButton)
        elementView.addSubview(shareButton)
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
            make.size.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        nickLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.leading.equalTo(profilePic.snp.trailing).offset(12)
        }
        
        nicknameButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(nickLabel)
            make.leading.equalTo(nickLabel)
        }
        
        optionButton.snp.makeConstraints { make in
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
