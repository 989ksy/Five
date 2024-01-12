//
//  ContentCollectionViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 11/30/23.
//

import UIKit
import SnapKit

final class ContentCollectionViewCell : BaseCollectionViewCell {
    
    static let ContentCollectionViewCell = "ContentCollectionViewCell"
    
    let imageView = {
       let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.backgroundColor = CustomColor.subColor
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let deleteButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Xmark.circle")?.withTintColor(.systemGray6), for: .normal)
        btn.setTitleColor(CustomColor.pointColor, for: .normal)
        btn.backgroundColor = .darkGray.withAlphaComponent(0.6)
        btn.layer.cornerRadius = 11
        
        return btn
    }()
    
    override func configureView() {
        addSubview(imageView)
        addSubview(deleteButton)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        deleteButton.snp.makeConstraints { make in
            make.size.equalTo(22)
            make.top.trailing.equalToSuperview()
        }
    }
    
    
}
