//
//  StyleViewCell.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/18.
//

import UIKit

class StyleViewCell: UICollectionViewCell, View {
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
    
    func bind(to viewModel: StyleCellViewModel) {
        viewModel.state.loadedStyleDTO.bind { [weak self] styleDTO in
            guard let self = self else { return }
            guard let thumbnailUrl = styleDTO.thumbnailURL else { return }
            self.thumbnailImageView.setImageWithCaching(from: thumbnailUrl)
//            guard let imageUrl = URL(string: urlString) else { return }
//            Task {
//                self.thumbnailImageView.image = await self.imageManager.loadImage(url: imageUrl)
//            }
        }
        viewModel.action.loadStyle.accept(())
    }
    
    private func layout() {
        addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
