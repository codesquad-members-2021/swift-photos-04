//
//  PhotoDataManager.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/25.
//

import UIKit
import Photos

class PhotoDataManager {
    public var allPhotos: PHFetchResult<PHAsset>
    static var shared = PhotoDataManager()
    public var imageManager: PHCachingImageManager
    public static var imageForSaving: UIImage?
    
    init() {
        allPhotos = PHAsset.fetchAssets(with: nil)
        imageManager = PHCachingImageManager()
    }
    
    static public func setImageForSaving(with image: UIImage) {
        self.imageForSaving = image
    }
    
    static public func saveImageForSaving() {
        UIImageWriteToSavedPhotosAlbum(imageForSaving!, nil, nil, nil)
    }
    
}
