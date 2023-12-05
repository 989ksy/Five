//
//  JournalViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit

final class JournalViewController: BaseViewController {
    
    let mainView = JournalView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        
        
    }
}
