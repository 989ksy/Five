//
//  SettingViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/2/23.
//

import UIKit
import RxCocoa
import RxSwift

import PhotosUI

final class SettingViewController : BaseViewController {
    
    let mainView = SettingView()
    let menuList = SettingMenu() //메뉴 리스트
    
    //프로필 화면에서 전달받은 값
    var transitedData = BehaviorRelay(value: MyProfileResponse(posts: [], followers: [], following: [], id: "", email: "", nick: ""))
    
    var imageInput: Data? //PublishRelay<Data>.init()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        
        //네비게이션바
        setNavigation()
        
        //테이블뷰
        mainView.settingTableView.delegate = self
        mainView.settingTableView.dataSource = self
                
        //PHPicker (이미지)
        mainView.imageChangeButton.addTarget(self, action: #selector(imageChangeButtonTapped), for: .touchUpInside)
        
        //키보드설정
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "개인설정"
    }
    
    //네트워크통신!
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        APIManager.shared.updateProfile(nick: transitedData.value.nick, profile: imageInput ?? <#default value#>)
//            .subscribe(with: self) { owner, response in
//                print(response)
//            }
//            .disposed(by: disposeBag)
        
        
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

    //MARK: - 네비게이션 설정
    func setNavigation() {
        self.title = "개인설정"
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationItem.titleView?.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
    }
    
    
}


extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableCell.identifier, for: indexPath) as? SettingTableCell else { return UITableViewCell() }
                
        let data = menuList.list[indexPath.row]
        
        cell.defaultLabel.text = data.label
        
        if indexPath.row == 0 {
            cell.detailLabel.text = transitedData.value.nick
        } else if indexPath.row == 1 {
            cell.detailLabel.text = transitedData.value.email
        } else {
            cell.detailLabel.text = "휴대폰 번호 미등록"
        }

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let vc = NickSettingViewController()
            vc.nickname = transitedData.value.nick
            vc.newNicknameCompletion = { [weak self] name in
                
                var updatedData = self?.transitedData.value
                updatedData?.nick = name
                self?.transitedData.accept(updatedData!)
                self?.mainView.settingTableView.reloadData()
                print("+++++", name)
            }
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}


//MARK: - 이미지 설정

extension SettingViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
                
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                if let image = object as? UIImage{
                    DispatchQueue.main.async {
                        self.mainView.profileImageView.image = image
                    }
                }
            }
        }
        
        let mappedImage = self.mainView.profileImageView.image.map { $0.jpegData(compressionQuality: 0.1)
        }.flatMap{ $0 }

        self.imageInput?.append(mappedImage!)
        
        
        picker.dismiss(animated: true, completion: nil)

        
    }
    
    
}
