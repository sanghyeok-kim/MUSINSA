//
//  PageCountSupplementaryView.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/22.
//

import UIKit

final class PageCountSupplementaryView: UICollectionReusableView, View {
    
    static var elementaryKind: String {
        return String(describing: self)
    }
    
    private lazy var label: RoundPaddingLabel = {
        let label = RoundPaddingLabel(padding: UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6))
        label.backgroundColor = .systemGray3
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "1 / 20"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to viewModel: PageCountSupplementaryViewModel) {
        viewModel.state.currentPageCount.bind { [weak self] count in
            
            
        }
        
        viewModel.state.maxPageCount.bind { [weak self] count in
            
            
        }
    }
    
    private func layout() {
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
