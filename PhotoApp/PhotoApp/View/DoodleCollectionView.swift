//
//  DoodleViewController.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/24.
//

import UIKit

class DoodleViewController: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
}
