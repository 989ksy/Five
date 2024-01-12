//
//  FiveCollectionViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 12/21/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FivedCollectionViewCell : BaseCollectionViewCell {
    
    static let identifier = "FivedCollectionViewCell"
    
    var disposeBag = DisposeBag()
    
    let firstImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "test_image")
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let moreIconImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "morePic")?.withTintColor(.white)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .darkGray.withAlphaComponent(0.4)
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func configureView() {
        
        addSubview(firstImageView)
        firstImageView.addSubview(moreIconImageView)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        firstImageView.image = nil
        moreIconImageView.image = nil
    }
    
    override func setConstraints() {
        
        firstImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        moreIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(6)
            make.size.equalTo(20)
        }
        
    }
    
    
}

