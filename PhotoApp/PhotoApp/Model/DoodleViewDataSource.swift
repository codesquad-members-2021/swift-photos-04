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
//            print(decodedData)
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
        
        let item = doodles[indexPath.row]
        let imageURL = item.image
        let url = URL(string: imageURL)!
        let data = try! Data(contentsOf: url)
        
        DispatchQueue.main.async {
            cell.imageView.image = UIImage(data: data)
        }
        
//        let asset = allPhotos.object(at: indexPath.item)
//        let imageManager = PHCachingImageManager()
//        imageManager.requestImage(for: asset,
//                                  targetSize: CGSize(width: 100, height: 100),
//                                  contentMode: .aspectFill,
//                                  options: nil,
//                                  resultHandler: { image, _ in
//                                        cell.imageView.image = image
//                                    })
//        cell.imageView.backgroundColor = .red
        return cell
    }
}

extension DoodleViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 50)
    }
}
