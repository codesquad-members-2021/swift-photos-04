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
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.addGestureRecognizer(longPress)
        self.backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.dataSource = doodleViewDataSource
        self.delegate = doodleViewDataSource
        doodleViewDataSource.parseDoodle()
        self.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.addGestureRecognizer(longPress)
        self.backgroundColor = .darkGray
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: self)
            guard let indexPath = self.indexPathForItem(at: touchPoint) else { return }
            guard let cell = self.cellForItem(at: indexPath) as? PhotoCell else { return }
            
            if let safeImage = cell.imageView.image {
                PhotoDataManager.setImageForSaving(with: safeImage)
                cell.becomeFirstResponder()
                enableCustomMenu(targetView: cell)
            }
        }
    }
    
    func enableCustomMenu(targetView: UICollectionViewCell) {
        let saveItem = UIMenuItem(title: "Save", action: #selector(savePhoto))
        let dummyItem = UIMenuItem(title: "Quit", action: #selector(doNotSave))
        UIMenuController.shared.menuItems = [saveItem, dummyItem]
        // rect is not valid here
        UIMenuController.shared.showMenu(from: targetView, rect: CGRect())
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }

    func disableCustomMenu() {
            UIMenuController.shared.menuItems = nil
    }
    
    @objc func savePhoto() {
        PhotoDataManager.saveImageForSaving()
    }
    @objc func doNotSave() {
        // do not save the photo when 'Quit' is pressed
    }
}
