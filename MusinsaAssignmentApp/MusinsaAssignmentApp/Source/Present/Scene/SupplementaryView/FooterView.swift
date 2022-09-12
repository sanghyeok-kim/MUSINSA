//
//  FooterView.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/18.
//

import UIKit

final class FooterView: UICollectionReusableView, View {
    
    private lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .capsule
        config.titleAlignment = .center
        config.baseForegroundColor = .black
        config.background.strokeWidth = 1 //borderWidth
        config.background.strokeColor = .systemGray //borderColor
        config.imagePadding = 3
        button.configuration = config
        return button
    }()
    
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray4
        
        addSubview(seeMoreButton)
        
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        seeMoreButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        seeMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func bind(to viewModel: FooterViewModel) {
        defer { viewModel.action.loadFooter.accept(()) }
        
        viewModel.state.loadedFooter.bind { [weak self] footerEntity in
            self?.seeMoreButton.setTitle(footerEntity.title, for: .normal)
            
            if let iconURL = footerEntity.iconURL {
                ImageCacheManager.shared.fetchImage(from: iconURL) { [weak self] result in
                    switch result {
                    case .success(let image):
                        let buttonImage = image?.resizedAspect(to: 20)
                        self?.seeMoreButton.configuration?.image = buttonImage
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .disposed(by: disposeBag)
        
        viewModel.state.shouldSeeMoreButtonHidden
            .bind { [weak self] bool in
                self?.seeMoreButton.isHidden = bool
            }
            .disposed(by: disposeBag)
        
        seeMoreButton.addAction(UIAction(identifier: .seeMoreButtonTapped, handler: { [weak self] _ in
            self?.viewModel?.action.seeMoreButtonTapped.accept(())
        }), for: .touchUpInside)
    }
}
