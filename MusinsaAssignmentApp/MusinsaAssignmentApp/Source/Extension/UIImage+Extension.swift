//
//  UIImage+Extension.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/09/12.
//

import UIKit

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        let render = UIGraphicsImageRenderer(size: newSize)
        let renderImage = render.image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        return renderImage
    }
    
    func resizedAspect(to newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        return resized(to: newSize)
    }
}
