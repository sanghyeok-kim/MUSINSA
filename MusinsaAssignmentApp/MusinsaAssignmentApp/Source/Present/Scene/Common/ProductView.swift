//
//  ProductView.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/22.
//

import UIKit

final class ProductView: UIView {
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var brandNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private lazy var saleRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .red
        return label
    }()
    
    private lazy var couponLabel: UILabel = {
        let label = UILabel()
        label.text = "쿠폰"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var productSaleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.spacing = 1
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubviews([priceLabel, saleRateLabel, couponLabel])
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        backgroundColor = .systemGray
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with productDTO: ProductEntity) {
        guard let thumbNailUrl = productDTO.thumbnailUrl else { return }
        self.thumbnailImageView.setImageWithCaching(from: thumbNailUrl)
        
        //guard let linkUrl = product.linkURL else { return }
        self.brandNameLabel.text = productDTO.brandName
//        if self.brandNameLabel.text == nil {
//            self.brandNameLabel.text = ""
//        }
//        self.brandNameLabel.text?.append(productDTO.brandName)
        self.priceLabel.text = productDTO.price
        self.saleRateLabel.text = productDTO.saleRate
        self.couponLabel.isHidden = productDTO.hasCoupon
    }
    
    private func layout() {
        addSubviews([thumbnailImageView, brandNameLabel, productSaleStackView])
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.15).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        brandNameLabel.translatesAutoresizingMaskIntoConstraints = false
        brandNameLabel.bottomAnchor.constraint(equalTo: productSaleStackView.topAnchor, constant: -8).isActive = true
        brandNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        productSaleStackView.translatesAutoresizingMaskIntoConstraints = false
        productSaleStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        productSaleStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        productSaleStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
 
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }

}
