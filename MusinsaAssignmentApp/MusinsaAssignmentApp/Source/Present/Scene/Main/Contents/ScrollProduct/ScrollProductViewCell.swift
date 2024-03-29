//
//  ScrollProductViewCell.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/18.
//

import UIKit

final class ScrollProductViewCell: UICollectionViewCell, View {
    
    private lazy var productView = ProductView()
    private lazy var button = UIButton()
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func bind(to viewModel: ScrollProductCellViewModel) {
        defer { viewModel.action.loadProduct.accept(()) }
        
        viewModel.state.loadedProductEntity.bind { [weak self] productEntiy in
            self?.productView.configure(with: productEntiy)
        }
        .disposed(by: disposeBag)
        
        button.addAction(UIAction(identifier: .cellTapped, handler: { _ in
            viewModel.action.cellTapped.accept(())
        }), for: .touchUpInside)
    }
    
    private func layout() {
        addSubviews([productView, button])
        
        productView.translatesAutoresizingMaskIntoConstraints = false
        productView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        productView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        productView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
