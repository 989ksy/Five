//
//  WriteView.swift
//  Five
//
//  Created by Seungyeon Kim on 11/27/23.
//

import UIKit
import SnapKit

class WriteView : BaseView {
    
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
    
    let uploadButton = {
        let btn = UIButton()
        btn.setTitle("게시하기", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = CustomFont.feedProfile15
        btn.layer.borderColor = CustomColor.pointColor?.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let contentTextfield = {
        let txtfield = UITextField()
        txtfield.placeholder = "  함께 하이파이브 하고 싶은 순간을 공유해주세요."
        txtfield.font = CustomFont.textfield15
        txtfield.textColor = .black
        txtfield.textAlignment = .left
        return txtfield
    }()
    
    override func configureView() {
        
        addSubview(upperView)
        upperView.addSubview(closeButton)
        upperView.addSubview(uploadButton)
        addSubview(contentTextfield)
        contentTextfield.backgroundColor = .systemGray6
        
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
        
        uploadButton.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalTo(72)
            make.trailing.equalToSuperview().inset(13)
            make.centerY.equalToSuperview()
        }
        
        contentTextfield.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
    }
    
    
}
