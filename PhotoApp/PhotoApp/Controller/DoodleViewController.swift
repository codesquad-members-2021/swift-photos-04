//
//  DoodleViewController.swift
//  PhotoApp
//
//  Created by kiyoungj on 2021/03/24.
//

import UIKit

class DoodleViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private var result = [DoodleModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        result = Service.shared.fetchDataFromParseJSON()
        self.collectionView.backgroundColor = .darkGray
    }
}

extension DoodleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int  {
        return result.count > 0 ? result.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoodleCollectionViewCell", for: indexPath) as? DoodleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = self.result[indexPath.item]
        let imageURL = item.image
        cell.configure(urlString: imageURL, doodleType: item)
        cell.urlImageView.tag = indexPath.item
        cell.urlImageView.isUserInteractionEnabled = true
        //        cell.becomeFirstResponder()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressedCell(gesture:)))
        longPressRecognizer.cancelsTouchesInView = false
        longPressRecognizer.numberOfTapsRequired = 1
        cell.urlImageView.addGestureRecognizer(longPressRecognizer)
        return cell
    }
}

extension DoodleViewController {
    
    @objc func longPressedCell(gesture: UILongPressGestureRecognizer) {
        guard let targetView = gesture.view, let superView = targetView.superview else { return }
        let saveMenuItem = UIMenuItem(title: "저장하기", action: #selector(saveImage(_:)))
        UIMenuController.shared.menuItems = [saveMenuItem]
        UIMenuController.shared.arrowDirection = .default
        UIMenuController.shared.setMenuVisible(true, animated: true)
        UIMenuController.shared.setTargetRect(targetView.frame, in: superView)
    }
    
    @objc func saveImage(_ sender: UIImage) {
        
    }
}


