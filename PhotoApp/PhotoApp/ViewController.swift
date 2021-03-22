//
//  ViewController.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        cell.backgroundColor = getRandomColor()
        return cell
    }
    
    func getRandomColor() -> UIColor {
        var random: UIColor {
            let r:CGFloat  = .random(in: 0...1)
            let g:CGFloat  = .random(in: 0...1)
            let b:CGFloat  = .random(in: 0...1)
            return UIColor(red: r, green: g, blue: b, alpha: 1)
        }
        return random
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
