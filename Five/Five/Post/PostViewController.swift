//
//  PostViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/7/23.
//

import UIKit
import RxSwift
import RxCocoa

final class PostViewController : BaseViewController {
    
    var transitedDataFromFeed = BehaviorRelay(value: CreatePostResponse(id: "", time: "", content: "", productId: "", likes: [], image: [], creator: Creator.init(id: "", nick: "")))
    
    let mainView = PostView()
    
    override func loadView() {
        self.view = mainView
    }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = CustomColor.backgroundColor
            
            navigationItem.titleView = mainView.titleStackView
        }

        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()

            if view.traitCollection.horizontalSizeClass == .compact {
                mainView.titleStackView.axis = .vertical
                mainView.titleStackView.spacing = UIStackView.spacingUseDefault
            } else {
                mainView.titleStackView.axis = .horizontal
                mainView.titleStackView.spacing = 20.0
            }
        }

    
    
    
}
