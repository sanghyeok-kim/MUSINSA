//
//  ScrollProductViewCell.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/18.
//

import UIKit

final class ScrollProductViewCell: UICollectionViewCell, View {
    private lazy var productView = ProductView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to viewModel: ScrollProductCellViewModel) {
        viewModel.state.loadedProductDTO.bind { [weak self] productDTO in
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
