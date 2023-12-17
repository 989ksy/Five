//
//  ProfileSecondTableViewCell .swift
//  Five
//
//  Created by Seungyeon Kim on 12/17/23.
//

import UIKit
import SnapKit

class ProfileSecondCell : BaseTableViewCell {
    
    static let identifier = "ProfileSecondCell"
    
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            fiveView.isHidden = shouldHideFirstView
            fivedView.isHidden = !self.fiveView.isHidden
        }
    }
    
    let segmentedControl = {
        let control = UnderlineSegmentedControl(items: ["Five","Fived"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let fiveView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.register(FiveCollectionViewCell.self, forCellWithReuseIdentifier: "FiveCollectionViewCell")
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
        contentView.addSubview(fiveView)
        
        fiveView.dataSource = self
        fiveView.delegate = self
        
        setSegmentedControl()
        
    }
    
    
    
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
    
    
    override func setConstraints() {
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.horizontalEdges.equalToSuperview().inset(120)
            make.height.equalTo(40)
        }
        
        fiveView.snp.makeConstraints { make in
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


extension ProfileSecondCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiveCollectionViewCell", for: indexPath) as? FiveCollectionViewCell else {return UICollectionViewCell()}
        
        cell.backgroundColor = .yellow
        
        return cell
    }
    
    
}
