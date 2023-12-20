//
//  NickSettingViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/20/23.
//

import UIKit
import SnapKit

class NickSettingViewController: BaseViewController {
    
    var nickname: String?
    var newNicknameCompletion : ((String) -> Void)?
    
    //MARK: - UI등록
   let mainView = NickSettingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "닉네임 변경"
        self.navigationController?.navigationBar.topItem?.title = ""
        
        view.backgroundColor = CustomColor.backgroundColor
        
        mainView.doneButton
            .addTarget(self,
                       action: #selector(doneButtonTapped),
                       for: .touchUpInside)
        
        mainView.nicknameTextfield.placeholder = nickname
    }
    
    
    //MARK: - 저장버튼
    
    @objc func doneButtonTapped() {
        
        guard let newNick = mainView.nicknameTextfield.text else { return }
        newNicknameCompletion?(newNick)

        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
