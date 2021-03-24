//
//  DoodleCollectionViewCell.swift
//  PhotoApp
//
//  Created by kiyoungj on 2021/03/24.
//

import UIKit

class DoodleCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var doodleType: DoodleModel!
    
    @IBOutlet weak var urlImageView: UIImageView!{
        didSet {
            self.urlImageView.contentMode = .scaleAspectFill
        }
    }
    
    func configure(urlString: String, doodleType: DoodleModel){
        self.urlImageView.load(urlString: urlString)
        self.doodleType = doodleType
    }
}
