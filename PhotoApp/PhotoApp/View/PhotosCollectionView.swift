//
//  PhotosCollectionView.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/23.
//

import UIKit
import Photos

class PhotosCollectionView: UICollectionView {
    let collectionViewDataSource = CollectionViewDataSource()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.dataSource = collectionViewDataSource
        self.delegate = collectionViewDataSource
        self.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        PHPhotoLibrary.shared().register(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.dataSource = collectionViewDataSource
        self.delegate = collectionViewDataSource
        self.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        PHPhotoLibrary.shared().register(self)
        self.backgroundColor = .red
    }
}

extension PhotosCollectionView: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        //PHChange에 main이 아닌 다른 스레드가 할당돼서 main.sync도 가능했었으나 main.async로 바꾸기로 함
        DispatchQueue.main.async {
            guard let changes = changeInstance.changeDetails(for: PhotoDataManager.shared.allPhotos) else { return }
            PhotoDataManager.shared.allPhotos = changes.fetchResultAfterChanges
            
            if changes.hasIncrementalChanges {
                self.performBatchUpdates({
                    if let removed = changes.removedIndexes , removed.count > 0 {
                        self.deleteItems(at: removed.map { IndexPath(item: $0, section:0) })
                    }
                    if let inserted = changes.insertedIndexes , inserted.count > 0 {
                        self.insertItems(at: inserted.map { IndexPath(item: $0, section:0) })
                    }
                    if let changed = changes.changedIndexes , changed.count > 0 {
                        self.reloadItems(at: changed.map { IndexPath(item: $0, section:0) })
                    }
                    changes.enumerateMoves { fromIndex, toIndex in
                        self.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                      to: IndexPath(item: toIndex, section: 0))
                    }
                })
            } else {
                self.reloadData()
            }
        }
    }
}
    
    
