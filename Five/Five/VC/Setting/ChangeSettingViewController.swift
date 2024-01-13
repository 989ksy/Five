//
//  NickSettingViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/20/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

import PhotosUI

final class ChangeSettingViewController: BaseViewController {
    
    var nickname: String?
//    var newNicknameCompletion : ((String) -> Void)?
    
    var imageInput: Data? //PublishRelay<Data>.init()
    
    //MARK: - UI등록
   let mainView = ChangeSettingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CustomColor.backgroundColor
        
        //PHPicker (이미지)
        mainView.imageChangeButton.addTarget(self, action: #selector(imageChangeButtonTapped), for: .touchUpInside)
        
        //창닫기
//        mainView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        mainView.nicknameTextfield.placeholder = nickname
        
        
        bind()
    }
    
    
    //MARK: - 저장버튼
    
    @objc func doneButtonTapped() {
        
        guard let newNick = mainView.nicknameTextfield.text else { return }
        
        self.dismiss(animated: true)

    }
    
    let disposeBag = DisposeBag()
    
    func bind() {
        
        mainView.doneButton.rx.tap
            .withLatestFrom(mainView.nicknameTextfield.rx.text.orEmpty)
            .withUnretained(self)
            .flatMap { owner, value in
                return APIManager.shared.updateProfile(nick: value, profile: owner.imageInput!)
            }
            .subscribe(with: self , onNext: { owner , response in
                print(response)
            })
            .disposed(by: disposeBag)
        
        
        
        
    }
    
    
    //MARK: - 프로필 이미지 설정
    
    @objc func imageChangeButtonTapped() {

        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    
}


//MARK: - 이미지 설정

extension ChangeSettingViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
                
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                if let image = object as? UIImage{
                    
                    self.imageInput = image.jpegData(compressionQuality: 0.01)
                    
                    DispatchQueue.main.async {
                        self.mainView.profileImageView.image = image
                    }
                }
            }
        }
        
        
        picker.dismiss(animated: true, completion: nil)

        
    }
    
    
}
