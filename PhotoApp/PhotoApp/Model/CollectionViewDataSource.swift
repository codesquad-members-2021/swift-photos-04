//
//  CollectionViewDataSource.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/23.
//

import UIKit

class CollectionViewDataSource: NSObject {
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoDataManager.shared.allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let asset = PhotoDataManager.shared.allPhotos.object(at: indexPath.item)
        
        PhotoDataManager.shared.imageManager.requestImage(for: asset,
                                  targetSize: CGSize(width: 100, height: 100),
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: { image, _ in
                                        cell.imageView.image = image
                                    })
        
        if asset.mediaSubtypes != .photoLive {
            cell.livephotoImageView.isHidden = true
        }
        
        return cell
    }
}

extension CollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }
}

