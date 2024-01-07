//
//  SearchCollectionViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 12/7/23.
//

import UIKit
import SnapKit

class LoadCell : BaseCollectionViewCell {
    
    static let identifier = "LoadCell"
    
     let mainImage = {
        let view = UIImageView()
        view.image = UIImage(named: "test_profile")
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
     let nicknameLabel = {
        let label = UILabel()
        label.text = "레옹"
        label.font = CustomFont.mediumGmarket15
        label.textColor = .black
        return label
    }()
    
    
    override func configureView() {
        contentView.addSubview(mainImage)
        contentView.addSubview(nicknameLabel)
    }
    
    override func setConstraints() {
//        mainImage.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalToSuperview().inset(2)
//            make.leading.equalToSuperview().offset(16)
//            make.top.equalToSuperview().offset(10)
//        }
//        
//        nicknameLabel.snp.makeConstraints { make in
//            make.leading.equalTo(mainImage.snp.trailing).offset(10)
//            make.height.equalTo(16)
//            make.top.equalToSuperview().offset(10)
//        }
        
        

    }
    
    
}
