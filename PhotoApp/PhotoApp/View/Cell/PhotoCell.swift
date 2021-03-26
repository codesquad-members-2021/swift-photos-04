//
//  PhotoCell.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/23.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var livephotoImageView: UIImageView!
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var isSelected: Bool{
      didSet{
        if self.isSelected
        {
          self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
          self.contentView.backgroundColor = UIColor.red
//          self.tickImageView.isHidden = false
        }
        else
        {
          self.transform = CGAffineTransform.identity
          self.contentView.backgroundColor = UIColor.gray
//          self.tickImageView.isHidden = true
        }
      }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
