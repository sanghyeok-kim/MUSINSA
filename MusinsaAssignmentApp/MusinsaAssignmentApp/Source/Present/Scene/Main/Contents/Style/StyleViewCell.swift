//
//  StyleViewCell.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/18.
//

import UIKit

class StyleViewCell: UICollectionViewCell, View {
    
    private var disposeBag = DisposeBag()
    private lazy var button = UIButton()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        button.removeAction(identifiedBy: .cellTapped, for: .touchUpInside)
    }
    
    func bind(to viewModel: StyleCellViewModel) {
        defer { viewModel.action.loadStyle.accept(()) }
        
        viewModel.state.loadedStyleDTO.bind { [weak self] styleEntity in
            guard let thumbnailUrl = styleEntity.thumbnailUrl else { return }
            self?.thumbnailImageView.setImageWithCaching(from: thumbnailUrl)
        }
        .disposed(by: disposeBag)
        
        button.addAction(UIAction(identifier: .cellTapped, handler: { _ in
            viewModel.action.cellTapped.accept(())
        }), for: .touchUpInside)
    }
    
    private func layout() {
        addSubviews([thumbnailImageView, button])
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
