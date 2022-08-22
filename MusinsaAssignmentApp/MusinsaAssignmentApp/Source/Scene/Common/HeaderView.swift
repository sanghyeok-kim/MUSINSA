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
        
        [titleLabel, iconImageView].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray4
        
        self.addSubview(headerStackView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        headerStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to viewModel: HeaderViewModel) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.setTitleLabel(text: nil)
    }
    
//    func setTitleLabel(text: String?) {
//        self.titleLabel.text = text
//    }
    
    func configure(with header: Header) {
        titleLabel.text = header.title
    }
}
