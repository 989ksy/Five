//
//  ContentViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/27/23.
//

import UIKit

class ContentViewController : BaseViewController {
    
    let mainView = ContentView()
    let placeholder = "메모하고 싶은 내용을 입력하세요."
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
        print("writeVC dismiss tapped")
    }
    
}
