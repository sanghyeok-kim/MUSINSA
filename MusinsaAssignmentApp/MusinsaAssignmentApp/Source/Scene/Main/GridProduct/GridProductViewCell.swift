//
//  GridProductViewCell.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/18.
//

import UIKit

final class GridProductViewCell: UICollectionViewCell, View {
    private lazy var productView = ProductView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        backgroundColor = .systemGray
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to viewModel: GridProductCellViewModel) {
        viewModel.state.loadedProduct.bind { [weak self] productDTO in
            guard let self = self else { return }
            self.productView.configure(with: productDTO)
        }
        
        viewModel.action.loadProduct.accept(())
    }
    
    private func layout() {
        addSubview(productView)
        
        productView.translatesAutoresizingMaskIntoConstraints = false
        productView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        productView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        productView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

//class ScaledHeightImageView: UIImageView {
//    override var intrinsicContentSize: CGSize {
//        guard let myImage = self.image else { return
//            CGSize(width: -1.0, height: -1.0)
//        }
//        let myImageWidth = myImage.size.width
//        let myImageHeight = myImage.size.height
//        let myViewWidth = self.frame.size.width
//        let ratio = myViewWidth / myImageWidth
//        let scaledHeight = myImageHeight * ratio
//        return CGSize(width: myViewWidth, height: scaledHeight)
//    }
//}
