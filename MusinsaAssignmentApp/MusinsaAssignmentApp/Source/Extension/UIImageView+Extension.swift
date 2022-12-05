//
//  Extension+UIImageView.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/22.
//

import UIKit

extension UIImageView {
    func setImageWithCaching(from url: URL) {
        ImageCacheManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
