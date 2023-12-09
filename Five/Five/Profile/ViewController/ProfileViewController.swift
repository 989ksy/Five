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
    
     private lazy var pageViewController: UIPageViewController = {
       let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
       vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
       vc.delegate = self
       vc.dataSource = self
       vc.view.translatesAutoresizingMaskIntoConstraints = false
       return vc
     }()
     
     var dataViewControllers: [UIViewController] {
       [FiveViewController(), FivedViewController()]
     }
    
     var currentPage: Int = 0 {
       didSet {
         // from segmentedControl -> pageViewController 업데이트
         print(oldValue, self.currentPage)
         let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
         self.pageViewController.setViewControllers(
           [dataViewControllers[self.currentPage]],
           direction: direction,
           animated: true,
           completion: nil
         )
       }
     }
    
    
    
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setSegmentedControl()
        
        self.changeValue(control: self.mainView.segmentedControl)

    }
    
    @objc private func changeValue(control: UISegmentedControl) {
      self.currentPage = control.selectedSegmentIndex
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


// pageViewController.dataSource = self
extension ProfileViewController: UIPageViewControllerDataSource {
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard
      let index = self.dataViewControllers.firstIndex(of: viewController),
      index - 1 >= 0
    else { return nil }
    return self.dataViewControllers[index - 1]
  }
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    guard
      let index = self.dataViewControllers.firstIndex(of: viewController),
      index + 1 < self.dataViewControllers.count
    else { return nil }
    return self.dataViewControllers[index + 1]
  }
}


extension ProfileViewController: UIPageViewControllerDelegate {
  func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool
  ) {
    guard
      let viewController = pageViewController.viewControllers?[0],
      let index = self.dataViewControllers.firstIndex(of: viewController)
    else { return }
    self.currentPage = index
      self.mainView.segmentedControl.selectedSegmentIndex = index
  }
}
