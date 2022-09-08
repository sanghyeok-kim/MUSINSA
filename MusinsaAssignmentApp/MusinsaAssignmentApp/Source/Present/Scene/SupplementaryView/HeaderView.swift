//
//  SupplementaryView.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/14.
//

import UIKit

final class HeaderView: UICollectionReusableView, View {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.addArrangedSubviews([iconImageView, titleLabel])
        return stackView
    }()
    
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray4
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
    
    func bind(to viewModel: HeaderViewModel) {
        defer { viewModel.action.loadData.accept(()) }
        
        viewModel.state.loadedData.bind { [weak self] headerDTO in
            self?.titleLabel.text = headerDTO.title
            self?.iconImageView.isHidden = headerDTO.iconUrl == nil
            if let iconUrl = headerDTO.iconUrl {
                self?.iconImageView.setImageWithCaching(from: iconUrl)
            }
        }
        .disposed(by: disposeBag)
    }
    
    private func layout() {
        addSubview(headerStackView)
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        headerStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        iconImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
}

//private extension HeaderView {
//    func configureIconButton(with url: URL?) {
//        guard let url = url else {
//            iconButton.isHidden = true
//            return
//        }
//
//        ImageCacheManager.shared.fetchImage(from: url) { result in
//            switch result {
//            case .success(let image):
//                DispatchQueue.main.async {
//                    self.iconButton.setImage(image, for: .normal)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
