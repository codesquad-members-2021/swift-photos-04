//
//  DoodleViewDataSource.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/24.
//

import UIKit
import Photos

class DoodleViewDataSource: NSObject {
    var doodles: [Doodle] = []
    
    func parseDoodle() {
        guard let urlPath = Bundle.main.url(forResource: "doodle", withExtension: "json") else { return }
        do{
            let data = try Data(contentsOf: urlPath)
            let decodedData = try JSONDecoder().decode([Doodle].self, from: data)
            doodles = decodedData
        } catch {
            print(error.localizedDescription)
        }
    }
}
                            
extension DoodleViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let item = self.doodles[indexPath.row]
        let imageURL = item.image
        if let url = URL(string: imageURL) {
            //helped to load second collectionView without delay
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: data)
                    }
                } catch {
                    print(error.localizedDescription)
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
