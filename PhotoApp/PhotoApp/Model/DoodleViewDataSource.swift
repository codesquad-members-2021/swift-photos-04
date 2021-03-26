//
//  DoodleViewDataSource.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/24.
//

import UIKit

class DoodleViewDataSource: NSObject {
    private var doodleManager = DoodleManager()
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL, handler: @escaping (UIImage) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            guard let downloadedImage = UIImage(data: data) else { return }
            handler(downloadedImage)
        }
    }
}
                            
extension DoodleViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodleManager.doodle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let item = self.doodleManager.doodle[indexPath.row]
        let imageURL = item.image
        if let url = URL(string: imageURL) {
            //helped to load second collectionView without delay
            DispatchQueue.global().async {
                self.downloadImage(from: url) { (uiimage) in
                    DispatchQueue.main.async {
                        cell.imageView.image = uiimage
                    }
                }
            }
        }
        return cell
    }
}

extension DoodleViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 50)
    }
}
