//
//  FooterView.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/18.
//

import UIKit

final class FooterView: UICollectionReusableView, View {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray4
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.setTitleLabel(text: nil)
//    }
    
    func bind(to viewModel: FooterViewModel) {
        viewModel.state.loadedFooter.bind { [weak self] footerDTO in
            
        }
        
        viewModel.action.loadFooter.accept(())
        
    }
}