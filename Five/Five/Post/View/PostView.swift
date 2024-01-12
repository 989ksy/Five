//
//  PostView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/7/23.
//

import UIKit
import SnapKit

class PostView : BaseView {
    
    //MARK: - 스크롤뷰
    
    let postScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let contentView = {
        let view = UIView()
        return view
    }()
    
    //MARK: - 네비게이션바
    
    lazy var titleStackView: UIStackView = {
        
        let titleLabel = UILabel()
        
        titleLabel.textAlignment = .center
        titleLabel.text = "닉네임"
        titleLabel.textColor = .darkGray
        titleLabel.font = .systemFont(ofSize: 13)
        
        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "게시물"
        subtitleLabel.font = .boldSystemFont(ofSize: 17)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        
        return stackView
    }()
    
    
    
    //MARK: - 프로필 상단
    
    let navigationborderLine = {
        let view = LineView()
        return view
    }()
    
    let profileView = {
        let view = UIView()
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
    
    let profileViewBottomLine = {
        let view = LineView()
        return view
    }()
    
    //MARK: - 이미지영역
    
    let imageCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "PostCollectionViewCell")
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = CustomColor.backgroundColor
        view.isPagingEnabled = true
        return view
    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 380)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }
    
    //MARK: - 버튼 영역
    
    let elementView = {
        let view = UIView()
        return view
    }()
    
    let fiveButton = {
        let btn = FiveButton()
        return btn
    }()
    
    let fiveCountLabel = {
        let label = UILabel()
        label.text = "공감 0개"
        label.font = CustomFont.mediumGmarket14
        label.textColor = .black
        return label
    }()
    
    let shareButton = {
        let btn = ShareButton()
        return btn
    }()

    
    //MARK: - 하단부 (내용 + 댓글)
    
    let contentLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textColor = .black
        view.numberOfLines = 0
        view.textAlignment = .left
        view.text =
        "1. 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려"
        return view
    }()
    
    let showCommentButton = {
        let btn = UIButton()
        btn.setTitle("댓글 모두 보기", for: .normal)
        btn.setTitleColor(.systemGray2, for: .normal)
        btn.titleLabel?.font = CustomFont.mediumGmarket14
        return btn
    }()
    
    let dateLabel = {
        let view = DateLabel()
        return view
    }()
    
    
    //MARK: - 세팅
    
    override func configureView() {
        
        self.addSubview(postScrollView)
        postScrollView.addSubview(contentView)
        
        addSubview(navigationborderLine)
        contentView.addSubview(profileView)
        profileView.addSubview(profilePic)
        profileView.addSubview(nickLabel)
        profileView.addSubview(optionButton)
        profileView.addSubview(profileViewBottomLine)
        
        contentView.addSubview(imageCollectionView)
        imageCollectionView.backgroundColor = .systemGray6
        
        contentView.addSubview(elementView)
        elementView.addSubview(fiveButton)
        elementView.addSubview(fiveCountLabel)
//        elementView.addSubview(commentButton)
        elementView.addSubview(shareButton)
//        elementView.addSubview(bookmarkButton)
        
        contentView.addSubview(contentLabel)
        contentView.addSubview(showCommentButton)
        contentView.addSubview(dateLabel)
                
    }
    
    override func setConstraints() {
        
        //MARK: - 스크롤뷰
        
        postScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(postScrollView)
            make.width.equalTo(postScrollView.snp.width)
        }
        
        
        //MARK: - 상단 닉네임바
        
        navigationborderLine.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
        }
        profileView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
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
        
        profileViewBottomLine.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
        }
        
        optionButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(17)
            make.trailing.equalToSuperview().inset(10)
        }
        
        //MARK: - 이미지 영역
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(380)
        }
        
        //MARK: - 버튼 영역
        
        elementView.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(36)
        }
        
        fiveButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
        
        fiveCountLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.equalTo(fiveButton.snp.trailing).offset(2)
            make.centerY.equalToSuperview()
        }
        
        shareButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.trailing.equalTo(elementView.snp.trailing).inset(12)
            make.centerY.equalToSuperview()
        }
        
        //MARK: - 하단영역
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(elementView.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(14)
        }
        
        showCommentButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(17)
            make.width.equalTo(100)
            make.bottom.equalTo(contentView.snp.bottom).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(13)
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(showCommentButton.snp.bottom).offset(9)
        }
        
        
    }
    
    
}
