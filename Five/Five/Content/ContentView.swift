//
//  ContentView.swift
//  Five
//
//  Created by Seungyeon Kim on 11/27/23.
//

import UIKit
import SnapKit

class ContentView : BaseView {
    
    let upperView = {
        let view = UIView()
        return view
    }()
    
    let closeButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.contentMode = .scaleAspectFill
        btn.tintColor = .darkGray
        return btn
    }()
    
    let newPostLabel = {
        let label = viewTitleLabel()
        label.text = "새 포스트"
        return label
    }()
    
    let upperLine = {
        let view = lineUIView()
        return view
    }()
    
    let uploadButton = {
        let btn = UIButton()
        btn.setTitle("게시", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = CustomFont.mediumGmarket15
        btn.layer.borderColor = CustomColor.pointColor?.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let contentTextView = {
        let txtfield = UITextView()
        txtfield.text = "함께 파이브 하고 싶은 순간을 공유해보세요."
        txtfield.font = CustomFont.mediumGmarket15
        txtfield.textColor = .gray
        txtfield.textAlignment = .left
        txtfield.backgroundColor = CustomColor.backgroundColor
        return txtfield
    }()
    
    let contentTextViewBottomLine = {
        let view = lineUIView()
        return view
    }()
    
    let imageAddButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "imageIcon")?.withTintColor(.lightGray), for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemGray3.cgColor
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    let imageCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = CustomColor.backgroundColor
        return view
    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 12
        let width = UIScreen.main.bounds.width - (spacing)
        layout.itemSize = CGSize(width: width/6 , height: width/6)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func configureView() {
        
        addSubview(upperView)
        upperView.addSubview(closeButton)
        upperView.addSubview(newPostLabel)
        upperView.addSubview(uploadButton)
        addSubview(upperLine)
        addSubview(contentTextView)
        addSubview(contentTextViewBottomLine)
        addSubview(imageAddButton)
        addSubview(imageCollectionView)

    }
    
    override func setConstraints() {
        
        upperView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(45)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(2)
            make.size.equalTo(45)
        }
        
        newPostLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
        }
        
        uploadButton.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(56)
            make.trailing.equalToSuperview().inset(13)
            make.centerY.equalToSuperview()
        }
        
        upperLine.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom).offset(13)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(220)
        }
        
        contentTextViewBottomLine.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        imageAddButton.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(8)
            make.size.equalTo(67)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(12)
            make.leading.equalTo(imageAddButton.snp.trailing).offset(3)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(67)
        }
        
        
    }
    
    
}
