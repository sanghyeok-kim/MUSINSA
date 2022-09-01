//
//  BannerViewCell.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import UIKit

final class BannerViewCell: UICollectionViewCell, View {
    
    private var disposeBag = DisposeBag()
    
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
        [titleLabel, descriptionLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    func bind(to viewModel: BannerCellViewModel) {
        viewModel.state.loadedBanner.bind { [weak self] bannerDTO in
            guard let thumbnailUrl = bannerDTO.thumbnailUrl else { return }
            self?.thumbnailImageView.setImageWithCaching(from: thumbnailUrl)
//            guard let linkUrl = bannerDTO.linkURL else { return }
            self?.keywordLabel.text = bannerDTO.keyword
            self?.titleLabel.text = bannerDTO.title
            self?.descriptionLabel.text = bannerDTO.description
        }
        .disposed(by: disposeBag)
        
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
    }
    
    private func layout() {
        addSubview(thumbnailImageView)
        addSubview(keywordLabel)
        addSubview(titleLabelStackView)
        
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
    }
}

