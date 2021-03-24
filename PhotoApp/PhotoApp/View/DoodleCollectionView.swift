//
//  DoodleViewController.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/24.
//

import UIKit

class DoodleCollectionView: UICollectionView {
    let doodleViewDataSource = DoodleViewDataSource()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.dataSource = doodleViewDataSource
        self.delegate = doodleViewDataSource
        doodleViewDataSource.parseDoodle()
        self.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.dataSource = doodleViewDataSource
        self.delegate = doodleViewDataSource
        doodleViewDataSource.parseDoodle()
        self.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
}
