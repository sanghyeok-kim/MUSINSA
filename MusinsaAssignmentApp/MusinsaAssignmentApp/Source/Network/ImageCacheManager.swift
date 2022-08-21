//
//  ImageManager.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import UIKit

enum ImageNetworkError: Error {
    case errorDetected
    case invalidFileLocation
}

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
        guard let diskCacheDirectoryUrl = self.diskCacheDirectoryUrl else { return nil } //유저 도메인의 캐시 디렉토리 위치
        let filePath = diskCacheDirectoryUrl.appendingPathComponent(imageName).path //cacheDirectory 경로에 있는 이미지 파일
        
        if fileManager.fileExists(atPath: filePath) { //disk에 있다면
            guard let image = UIImage(contentsOfFile: filePath) else { return nil } //disk에서 꺼내서
            memoryCache.setObject(image, forKey: imageName as NSString) //memoryCache에 저장
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
            
            //disk caching
            let imageName = url.lastPathComponent
            //tempDirectoryUrl.lastPathComponent로 하면 안됨!!! 임시 폴더의 임시 파일이라 매번 이름이 달라져서 캐싱 안됨!!! ㅠㅠ
            
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

extension UIImageView {
    func setImageWithCaching(from url: URL) {
        ImageCacheManager.shared.getImage(from: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async { self.image = image }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


//final class ImageManager {
//
//    static let shared = ImageManager()
//
//    private let imageCache = NSCache<NSString, UIImage>()
//
//    func loadImage(url: URL) async -> UIImage? {
//        let imageName = url.lastPathComponent
//
//        if let cacheImage = self.imageCache.object(forKey: imageName as NSString) {
//            return cacheImage
//        }
//
//        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
//            return UIImage()
//        }
//
//        let destination = cachesDirectory.appendingPathComponent(imageName)
//
//        if FileManager.default.fileExists(atPath: destination.path),
//           let image = UIImage(contentsOfFile: destination.path) {
//            self.imageCache.setObject(image, forKey: imageName as NSString)
//            return image
//        }
//
//        let result = Task { () -> UIImage? in
//            guard let (url, _) = try? await URLSession.shared.download(from: url) else {
//                return nil
//            }
//            try? FileManager.default.copyItem(at: url, to: destination)
//            guard let image = UIImage(contentsOfFile: destination.path) else {
//                return UIImage()
//            }
//            self.imageCache.setObject(image, forKey: imageName as NSString)
//            return image
//        }
//
//        return await result.value
//    }
//}
