//
//  GridProductSectionViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import UIKit

final class GridProductSectionDataSource: SectionDataSource {
    
    private lazy var layoutItem: NSCollectionLayoutItem = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / 3),
            heightDimension: .fractionalHeight(1)
        )
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        return layoutItem
    }()
    
    private lazy var layoutGroup: NSCollectionLayoutGroup = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1 / 2)
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: layoutSize,
            subitems: [layoutItem]
        )
        return layoutGroup
    }()
    
    lazy var layoutSection: NSCollectionLayoutSection = {
        let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)
        sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        sectionLayout.interGroupSpacing = 10
        appendHeader(to: sectionLayout)
        appendFooter(to: sectionLayout)
        return sectionLayout
    }()
    
    var itemCount: Int {
        return sectionDataCount
    }
    
    private var sectionDataCount = 0
    private let disposeBag = DisposeBag()
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GridProductViewCell.identifier,
            for: indexPath
        ) as? GridProductViewCell else { return UICollectionViewCell() }
        
        viewModel?.bindCellViewModel(for: cell, at: indexPath.item)
        return cell
    }
    
    func dequeueSupplementaryView(_ collectionView: UICollectionView,
                                  viewForSupplementaryElementOfKind kind: String,
                                  at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return dequeueReusableHeaderView(collectionView, at: indexPath, with: viewModel)
        case UICollectionView.elementKindSectionFooter:
            return dequeueReusableFooterView(collectionView, at: indexPath, with: viewModel)
        default:
            return UICollectionReusableView()
        }
    }
}

extension GridProductSectionDataSource: View {
    func bind(to viewModel: GridProductSectionDataSourceViewModel) {
        defer { viewModel.action.loadData.accept(()) }
        
        viewModel.state.itemCount
            .bind(onNext: { [weak self] count in
                self?.sectionDataCount = count
            })
            .disposed(by: disposeBag)
    }
}

extension GridProductSectionDataSource: HeaderUsable {
    func appendHeader(to layoutSection: NSCollectionLayoutSection) {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.05)
        )
        
        let layoutHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        layoutSection.boundarySupplementaryItems.append(layoutHeader)
    }
}

extension GridProductSectionDataSource: FooterUsable {
    func appendFooter(to layoutSection: NSCollectionLayoutSection) {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.05)
        )
        
        let layoutFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        layoutSection.boundarySupplementaryItems.append(layoutFooter)
    }
}
