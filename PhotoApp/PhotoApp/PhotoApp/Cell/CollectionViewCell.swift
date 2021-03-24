//
//  CollectionViewCell.swift
//  PhotoApp
//
//  Created by kiyoungj on 2021/03/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView! {
        didSet {
            self.albumImageView.contentMode = .scaleAspectFill
        }
    }
}
