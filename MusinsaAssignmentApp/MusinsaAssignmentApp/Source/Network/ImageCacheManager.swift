//
//  ImageManager.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    
    private var diskCacheDirectoryUrl: URL? {
        return fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
    }
    
    private init() { }
    
    private func findInMemory(from url: URL) -> UIImage? {
        let imageName = url.lastPathComponent
        let cachedImage = memoryCache.object(forKey: imageName as NSString)
        return cachedImage
    }
    
    private func findInDisk(from url: URL) -> UIImage? {
        let imageName = url.lastPathComponent
        guard let diskCacheDirectoryUrl = self.diskCacheDirectoryUrl else { return nil }
        let filePath = diskCacheDirectoryUrl.appendingPathComponent(imageName).path
        
        if fileManager.fileExists(atPath: filePath) {
            guard let image = UIImage(contentsOfFile: filePath) else { return nil }
            memoryCache.setObject(image, forKey: imageName as NSString)
            return image
        } else {
            return nil
        }
    }
    
    private func fetchImage(from url: URL, completion: @escaping((Result<UIImage?, ImageNetworkError>) -> Void)) {
        URLSession.shared.downloadTask(with: url) { [weak self] location, response, error in
            guard let self = self else { return }
            
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
            guard let diskCacheDirectoryUrl = self.diskCacheDirectoryUrl else { return }
            let destinationUrl = diskCacheDirectoryUrl.appendingPathComponent(imageName)
            try? self.fileManager.copyItem(at: tempDirectoryUrl, to: destinationUrl)
            
            //memory caching
            guard let image = UIImage(contentsOfFile: destinationUrl.path) else { return }
            self.memoryCache.setObject(image, forKey: imageName as NSString)
            
            completion(.success(image))
        }.resume()
    }
    
    func getImage(from url: URL, completion: @escaping (Result<UIImage?, ImageNetworkError>) -> ()) {
        if let image = ImageCacheManager.shared.findInMemory(from: url) {
            completion(.success(image))
        } else if let image = ImageCacheManager.shared.findInDisk(from: url) {
            completion(.success(image))
        } else {
            fetchImage(from: url, completion: completion)
        }
    }
}
