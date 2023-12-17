//
//  ProfileSecondTableViewCell .swift
//  Five
//
//  Created by Seungyeon Kim on 12/17/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProfileSecondCell : BaseTableViewCell {
    
    //MARK: - identifier 등록
    static let identifier = "ProfileSecondCell"
    
    let disposeBag = DisposeBag()
    let viewModel = ProfileSecondCellViewModel()
    

    //MARK: - UI
    
    let fiveCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.register(FiveCollectionViewCell.self, forCellWithReuseIdentifier: "FiveCollectionViewCell")
        view.backgroundColor = CustomColor.backgroundColor
        return view
    }()
    
    let fivedView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 3
        let numberOfItemsInRow: CGFloat = 3
        
        let width = (UIScreen.main.bounds.width - (numberOfItemsInRow + 1) * spacing) / numberOfItemsInRow
        layout.itemSize = CGSize(width: width, height: width)
        
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
        
    }
    
    override func configureView() {
        contentView.addSubview(segmentedControl)
        contentView.addSubview(fivedView)
        contentView.addSubview(fiveCollectionView)
        
        setSegmentedControl()
        bind()
        
    }
    
    //MARK: - cell
    
    func bind() {
        
        let input = ProfileSecondCellViewModel.Input(prefetchItem: fiveCollectionView.rx.prefetchItems)
        
        let output = viewModel.transform(input: input)
        
        output.profileItems
            .observe(on: MainScheduler.instance)
            .bind(to: fiveCollectionView.rx.items(cellIdentifier: "FiveCollectionViewCell", cellType: FiveCollectionViewCell.self)
            ) { (row, element, cell) in
                
                let url = URL(string: "\(BaseURL.base)" + element.image.first!)
                cell.firstImageView.loadImage(from: url!, placeHolderImage: UIImage(named: "strar.fill"))
                
                if element.image.count < 2 {
                    cell.moreIconImageView.isHidden = true
                }
                
            }
            .disposed(by: disposeBag)
        
    }
    
    
    
    //MARK: - SegmentedControl 설정
    
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            fiveCollectionView.isHidden = shouldHideFirstView
            fivedView.isHidden = !self.fiveCollectionView.isHidden
        }
    }
    
    let segmentedControl = {
        let control = UnderlineSegmentedControl(items: ["Five","Fived"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
    
    
    func setSegmentedControl() {
        
        segmentedControl.addTarget(self, action: #selector(didChangeValue(segment: )), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: CustomColor.pointColor ?? .systemYellow,
                .font: CustomFont.mediumGmarket15 ?? .systemFont(ofSize: 15)
            ],
            for: .selected
        )
        segmentedControl.selectedSegmentIndex = 0
        
    }
    
    //MARK: - 레이아웃
    
    override func setConstraints() {
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.horizontalEdges.equalToSuperview().inset(120)
            make.height.equalTo(40)
        }
        
        fiveCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        fivedView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
}
