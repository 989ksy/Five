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
    
    let contentTextfield = {
        let txtfield = UITextView()
        txtfield.text = "  함께 하이파이브 하고 싶은 순간을 공유해주세요."
        txtfield.font = CustomFont.textfield15
        txtfield.textColor = .black
        txtfield.textAlignment = .left
//        txtfield.backgroundColor = .systemGray6
        return txtfield
    }()
    
    let addButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "customPlus"), for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = CustomColor.pointColor?.cgColor
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    let firstImageView = {
       let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.borderColor = CustomColor.pointColor?.cgColor
        view.layer.cornerRadius = 6
        view.backgroundColor = CustomColor.subColor
        return view
    }()
    
    let secondImageView = {
       let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.borderColor = CustomColor.pointColor?.cgColor
        view.layer.cornerRadius = 6
        view.backgroundColor = CustomColor.subColor
        return view
    }()
    
    let thirdImageView = {
       let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.borderColor = CustomColor.pointColor?.cgColor
        view.layer.cornerRadius = 6
        view.backgroundColor = CustomColor.subColor
        return view
    }()
    
    override func configureView() {
        
        addSubview(upperView)
        upperView.addSubview(closeButton)
        upperView.addSubview(newPostLabel)
        upperView.addSubview(uploadButton)
        addSubview(contentTextfield)
        addSubview(addButton)
        addSubview(firstImageView)
        addSubview(secondImageView)
        addSubview(thirdImageView)

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
        
        contentTextfield.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(contentTextfield.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.size.equalTo(67)
        }
        
        firstImageView.snp.makeConstraints { make in
            make.top.equalTo(contentTextfield.snp.bottom).offset(8)
            make.leading.equalTo(addButton.snp.trailing).offset(13)
            make.size.equalTo(67)
        }
        secondImageView.snp.makeConstraints { make in
            make.top.equalTo(contentTextfield.snp.bottom).offset(8)
            make.leading.equalTo(firstImageView.snp.trailing).offset(8)
            make.size.equalTo(67)
        }
        thirdImageView.snp.makeConstraints { make in
            make.top.equalTo(contentTextfield.snp.bottom).offset(8)
            make.leading.equalTo(secondImageView.snp.trailing).offset(8)
            make.size.equalTo(67)
        }
        
    }
    
    
}
