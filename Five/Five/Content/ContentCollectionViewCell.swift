//
//  ContentCollectionViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 11/30/23.
//

import UIKit
import SnapKit

class ContentCollectionViewCell : BaseCollectionViewCell {
    
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
    
    override func configureView() {
        addSubview(imageView)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
