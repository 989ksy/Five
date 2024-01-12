//
//  PostCollectionViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 12/13/23.
//

import UIKit
import SnapKit

final class PostCollectionViewCell : BaseCollectionViewCell {
    
    static let identifier = "PostCollectionViewCell"
    
    let uploadedImaegView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let countBackView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let countLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = CustomFont.mediumGmarket12
        view.textAlignment = .center
        return view
    }()
    
    
    override func configureView() {
        
        addSubview(uploadedImaegView)
        uploadedImaegView.backgroundColor = .brown
        addSubview(countBackView)
        countBackView.addSubview(countLabel)
        
    }
    
    override func setConstraints() {
        
        uploadedImaegView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        countBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(28)
            make.width.equalTo(43)
            make.trailing.equalToSuperview().inset(12)
        }
        countLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()

        }
        
    }
    
}
