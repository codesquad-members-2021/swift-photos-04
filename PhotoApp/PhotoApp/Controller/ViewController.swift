//
//  DoodleViewController.swift
//  PhotoApp
//
//  Created by kiyoungj on 2021/03/24.
//

import UIKit
import Photos
import PhotosUI

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var fetchResult = PHFetchResult<PHAsset>()
    var canAccessImages: [UIImage] = []
    var thumbnailSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: (UIScreen.main.bounds.width / 3) * scale, height: 100 * scale)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self)
        navigationController?.navigationBar.topItem?.title = "Photos"
        getCanAccessImages()
    }
    
    func requestPHPhotoLibraryAuthorization(completion: @escaping () -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
            switch status {
            case .limited:
                PHPhotoLibrary.shared().register(self)
                completion()
            default:
                break
            }
        }
    }
    
    func getCanAccessImages() {
        self.canAccessImages = []
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        let fetchOptions = PHFetchOptions()
        self.fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        self.fetchResult.enumerateObjects { (asset, _, _) in
            PHImageManager().requestImage(for: asset, targetSize: self.thumbnailSize, contentMode: .aspectFill, options: requestOptions) { (image, info) in
                guard let image = image else { return }
                self.canAccessImages.append(image)
                DispatchQueue.main.async {
                    self.collectionView.insertItems(at: [IndexPath(item: self.canAccessImages.count - 1, section: 0)])
                }
            }
        }
    }
}

extension ViewController: PHPhotoLibraryChangeObserver {
    //MARK: PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        self.getCanAccessImages()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.canAccessImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.albumImageView.image = self.canAccessImages[indexPath.item]
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    //MARK: 지정된 셀의 크기를 반환하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

