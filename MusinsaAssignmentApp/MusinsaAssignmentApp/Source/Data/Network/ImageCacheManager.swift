//
//  ImageManager.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import UIKit
//TODO: memory cache manager, disk cache manager 분리, 각각의 save / find 구현
final class ImageCacheManager { //NSObject, NSCacheDelegate
    
    static let shared = ImageCacheManager()
    
    private let memoryCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 1024 * 1024 * 20
        return cache
    }()
    
    private let fileManager = FileManager.default
    
    private var diskCacheDirectoryUrl: URL? {
        return fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
    }
    
    private init() { }
    
    private func lookUpMemory(for url: URL) -> UIImage? {
        let imageName = url.lastPathComponent
        let cachedImage = memoryCache.object(forKey: imageName as NSString)
        return cachedImage
    }
    
    private func lookUpDisk(for url: URL) -> UIImage? {
        let imageName = url.lastPathComponent
        guard let diskCacheDirectoryUrl = self.diskCacheDirectoryUrl else { return nil }
        let filePath = diskCacheDirectoryUrl.appendingPathComponent(imageName)
        
        if fileManager.fileExists(atPath: filePath.path) {
            //memory caching
            guard let imageData = try? Data(contentsOf: filePath),
                  let image = UIImage(data: imageData) else { return nil }
            let imageSize = imageData.count
            memoryCache.setObject(image, forKey: imageName as NSString, cost: imageSize)
            return image
        } else {
            return nil
        }
    }
    
    private func storeAtMemory() {
        
    }
    
    private func downloadImage(from url: URL, completion: @escaping((Result<UIImage?, ImageNetworkError>) -> Void)) {
        URLSession.shared.downloadTask(with: url) { [weak self] location, response, error in
            if error != nil {
                completion(.failure(.errorDetected))
                return
            }
            
            guard let tempDirectoryUrl = location else {
                completion(.failure(.invalidFileLocation))
                return
            }
            
            let imageName = url.lastPathComponent
            
            //disk caching
            guard let diskCacheDirectoryUrl = self?.diskCacheDirectoryUrl else { return }
            let destinationUrl = diskCacheDirectoryUrl.appendingPathComponent(imageName)
            try? self?.fileManager.copyItem(at: tempDirectoryUrl, to: destinationUrl)
            
            //memory caching
            guard let imageData = try? Data(contentsOf: destinationUrl),
                  let image = UIImage(data: imageData) else { return }
            let imageSize = imageData.count
            self?.memoryCache.setObject(image, forKey: imageName as NSString, cost: imageSize)
            completion(.success(image))
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage?, ImageNetworkError>) -> ()) {
        //look up memory cache
        if let image = ImageCacheManager.shared.lookUpMemory(for: url) {
//            print("memory hit")
            completion(.success(image))
            return
        }
        
        //look up disk cache
        if let image = ImageCacheManager.shared.lookUpDisk(for: url) {
//            print("disk hit")
            completion(.success(image))
            return
        }
        
        //fetch from server
        downloadImage(from: url, completion: completion)
    }
    
//    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
//        print("evicted")
//    }
}
