//
//  imageCollectionView+Extension.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit


//MARK: - collectionView Extension

extension ContentViewController : UICollectionViewDelegate, UICollectionViewDataSource {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return selectedImage.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else {return UICollectionViewCell()}
    
    let selectedPhoto = selectedImage[indexPath.item]
    cell.imageView.image = selectedPhoto.image
    
    return cell
}


}
