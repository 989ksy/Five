//
//  ContentViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/27/23.
//

import UIKit
import YPImagePicker
import RxSwift
import RxCocoa

final class ContentViewController : BaseViewController {
    
    let mainView = ContentView()
    let viewModel = ContentViewModel()
    
    let disposeBag = DisposeBag()
    
    private lazy var selectedImage: [YPMediaPhoto] = []

    // Input으로 넣을 이미지 스트림
    let imageInput = PublishRelay<[Data]>.init()
    
    override func loadView() {
        self.view = mainView
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        
        //버튼 액션
        mainView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        mainView.imageAddButton.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
        
        // 딜리게이트
        mainView.contentTextView.delegate = self
        mainView.imageCollectionView.delegate = self
        mainView.imageCollectionView.dataSource = self
        
//        mainView.contentTextView.becomeFirstResponder()
        
        //게시물 게시
        bind()
     
//        print("===contentVC ViewDidLoad호출: \(KeychainStorage.shared.userToken!)")
    }
    
    //MARK: - 이미지 업로드
    
    @objc func addImageButtonTapped() {
        var config = YPImagePickerConfiguration()
        
        //디폴트 설정
        config.library.maxNumberOfItems = 5 // 최대 선택 가능한 사진 개수 제한
        config.library.mediaType = .photo // 미디어타입
        config.screens = [.library] //보여줄 화면
        config.startOnScreen = .library // 갤러리 첫 시작화면
        config.library.options = nil
        config.showsPhotoFilters = false // 카메리 필터 싫어
        config.library.isSquareByDefault = false
        config.shouldSaveNewPicturesToAlbum = false //새이미지를 라이브러리에 저장하지 않음.
        
        //피커 설정
        let picker = YPImagePicker(configuration: config)
        
        self.present(picker, animated: true, completion: nil) //피커 띄워
        
        //이미지 선택 및 취소버튼 액션
        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            if cancelled {
                
                picker.dismiss(animated: true, completion: nil)
                self.selectedImage.removeAll()
                
            } else {
                for item in items.prefix(5) {
                    switch item {
                    case .photo(let photo):
                        self.selectedImage.append(photo)
                        self.mainView.imageCollectionView.reloadData()
                        print(photo)
                    default: break
                    }
                }
                
                let mappedImage = self.selectedImage.map { $0.image.jpegData(compressionQuality: 0.1)
                }.flatMap{ $0 }

                self.imageInput.accept(mappedImage)
                
                self.mainView.imageCollectionView.reloadData()
            }
            picker.dismiss(animated: true, completion: nil)

        }
        
        
    }
    
    
    //MARK: - 닫기 버튼 작동
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
        print("writeVC dismiss tapped")
    }
    
    
    //MARK: - 업로드 버튼 작동
    
    
    func bind() {
        
        let input = ContentViewModel.Input(
            uploadTap: mainView.uploadButton.rx.tap,
            textContent: mainView.contentTextView.rx.text.orEmpty,
            images: imageInput.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.isSucceeded
            .subscribe(with: self) { owner, bool in
                if bool {
                    
                    self.dismiss(animated: true)
                    
                } else {
                    self.alertMessage(title: "알림", message: "포스트를 업로드 할 수 없습니다. 다시 시도해주세요.")
                }
            }
            .disposed(by: disposeBag)
        
        
    }

    
    //MARK: - alert
    
    func alertMessage(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style:.default)
        
        alert.addAction(ok)
        
       present(alert, animated: true)
    }
    
    
}




    //MARK: - collectionView Extension

extension ContentViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if selectedImage.count < 6 {
            return selectedImage.count
        } else {
            alertMessage(title: "안내", message: "사진은 최대 5개까지 추가할 수 있습니다.")
            print("5개 초과!")
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else {return UICollectionViewCell()}
        
        let selectedPhoto = selectedImage[indexPath.item]
        cell.imageView.image = selectedPhoto.image
        
        return cell
    }
    
    
}

