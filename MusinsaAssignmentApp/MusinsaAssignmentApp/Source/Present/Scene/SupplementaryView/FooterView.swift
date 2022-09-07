//
//  FooterView.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/18.
//

import UIKit

final class FooterView: UICollectionReusableView, View {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 2.0
        return button
    }()
    
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray4
        
        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
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
        
        viewModel.state.loadedFooter.bind { [weak self] footerDTO in
            self?.button.setTitle(footerDTO.title, for: .normal)
            
            if let iconURL = footerDTO.iconURL {
                let buttonImage = UIImage(named: "pencil")
                self?.button.setImage(buttonImage, for: .normal)
            }
        }
        .disposed(by: disposeBag)
    }
}
