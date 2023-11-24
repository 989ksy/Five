//
//  BaseViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        
    }
    
    func configureView() {
        view.backgroundColor = .white
        
    }
    
    func setConstraints() {
        
    }
    
    
    
}

