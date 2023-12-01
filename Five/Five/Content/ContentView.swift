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
        let label = UILabel()
        label.text = "새 게시물"
        label.font = CustomFont.feedProfile15
        return label
    }()
    
    let uploadButton = {
        let btn = UIButton()
        btn.setTitle("게시", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = CustomFont.feedProfile15
        btn.layer.borderColor = CustomColor.pointColor?.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let contentTextView = {
        let txtfield = UITextView()
        txtfield.text = "함께 하이파이브 하고 싶은 순간을 공유해주세요."
        txtfield.font = CustomFont.textfield15
        txtfield.textColor = .gray
        txtfield.textAlignment = .left
        return txtfield
    }()
    
    let imageAddButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "imageIcon")?.withTintColor(.lightGray), for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = CustomColor.pointColor?.cgColor
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    let imageCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
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
        addSubview(contentTextView)
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
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom).offset(13)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        imageAddButton.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.size.equalTo(67)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(8)
            make.leading.equalTo(imageAddButton.snp.trailing).offset(3)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(67)
        }
        
        
    }
    
    
}
