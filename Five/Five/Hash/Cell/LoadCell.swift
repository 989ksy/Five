//
//  SearchCollectionViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 12/7/23.
//

import UIKit
import SnapKit

final class LoadCell : BaseCollectionViewCell {
    
    static let identifier = "LoadCell"
    
     let mainImage = {
        let view = UIImageView()
        view.image = UIImage(named: "test_profile")
        view.layer.cornerRadius = 4
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(mainImage)
    }
    
    override func setConstraints() {
        mainImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
