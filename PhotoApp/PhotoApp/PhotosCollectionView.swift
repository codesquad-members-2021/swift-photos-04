//
//  PhotosCollectionView.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/23.
//

import UIKit


class PhotosCollectionView: UICollectionView {
    let collectionViewDataSource = CollectionViewDataSource()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.dataSource = collectionViewDataSource
        self.delegate = collectionViewDataSource
        self.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.dataSource = collectionViewDataSource
        self.delegate = collectionViewDataSource
        self.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
}
