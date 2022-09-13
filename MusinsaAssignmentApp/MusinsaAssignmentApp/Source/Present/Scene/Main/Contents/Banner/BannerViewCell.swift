//
//  BannerViewCell.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import UIKit

final class BannerViewCell: UICollectionViewCell, View {
    
    private lazy var button = UIButton()
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var keywordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var titleLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.addArrangedSubviews([titleLabel, descriptionLabel])
        return stackView
    }()
    
    private var disposeBag = DisposeBag()
    
    func bind(to viewModel: BannerCellViewModel) {
        viewModel.state.loadedBanner.bind { [weak self] bannerEntity in
            guard let thumbnailUrl = bannerEntity.thumbnailUrl else { return }
            self?.thumbnailImageView.setImageWithCaching(from: thumbnailUrl)
            self?.keywordLabel.text = bannerEntity.keyword
            self?.titleLabel.text = bannerEntity.title
            self?.descriptionLabel.text = bannerEntity.description
        }
        .disposed(by: disposeBag)
        
        button.addAction(UIAction(identifier: .cellTapped, handler: { _ in
            viewModel.action.cellTapped.accept(())
        }), for: .touchUpInside)
        
        viewModel.action.loadBanner.accept(())
    }
    
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
    
    private func layout() {
        addSubviews([thumbnailImageView, keywordLabel, titleLabelStackView, button])
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        keywordLabel.translatesAutoresizingMaskIntoConstraints = false
        keywordLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 24).isActive = true
        keywordLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: 12).isActive = true
        
        titleLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabelStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: 12).isActive = true
        titleLabelStackView.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -24).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
