//
//  WriteViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/27/23.
//

import UIKit

class WriteViewController : BaseViewController {
    
    let mainView = WriteView()
    
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
        print("tap")
    }
    
}
