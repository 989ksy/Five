//
//  CommentViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/3/23.
//

import UIKit

final class CommentViewController : BaseViewController {
    
    let mainView = CommentView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        
        
    }
    
}
