//
//  PhotoDataManager.swift
//  PhotoApp
//
//  Created by 조중윤 on 2021/03/25.
//

import Foundation
import Photos

class PhotoDataManager {
    public var allPhotos: PHFetchResult<PHAsset>
    static var shared = PhotoDataManager()
    public var imageManager: PHCachingImageManager
    
    init() {
        allPhotos = PHAsset.fetchAssets(with: nil)
        imageManager = PHCachingImageManager() 
    }
}
