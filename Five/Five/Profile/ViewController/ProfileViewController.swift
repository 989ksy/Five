//
//  ProfileViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/29/23.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    let viewModel = ProfileViewModel()
    
    let disposeBag = DisposeBag()
    
    var shouldHideFirstView: Bool? {
      didSet {
        guard let shouldHideFirstView = self.shouldHideFirstView else { return }
          self.mainView.fiveView.isHidden = shouldHideFirstView
          self.mainView.fivedView.isHidden = !self.mainView.fiveView.isHidden
      }
    }
    
    
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setSegmentedControl()
        
        mainView.fiveView.delegate = self
        mainView.fiveView.dataSource = self
        
    }

    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
      }
    
    func setSegmentedControl() {
        
        self.mainView.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment: )), for: .valueChanged)
        self.mainView.segmentedControl.selectedSegmentIndex = 0
        self.mainView.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
            self.mainView.segmentedControl.setTitleTextAttributes(
              [
                NSAttributedString.Key.foregroundColor: CustomColor.pointColor ?? .systemYellow,
                .font: CustomFont.mediumGmarket15 ?? .systemFont(ofSize: 15)
              ],
              for: .selected
            )
            self.mainView.segmentedControl.selectedSegmentIndex = 0
        

        
    }
    
    
    //MARK: - 버튼 동작 RxSwift
    
    func bind() {
        
        let input = ProfileViewModel.Input(settingTap: mainView.settingButton.rx.tap)
        
        mainView.settingButton.rx.tap
            .subscribe(with: self) { owner, _ in
                let vc = SettingViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    
}



extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiveCollectionViewCell", for: indexPath) as? FiveCollectionViewCell else {return UICollectionViewCell()}

        cell.backgroundColor = .yellow
        
        return cell
    }
    
    
}
