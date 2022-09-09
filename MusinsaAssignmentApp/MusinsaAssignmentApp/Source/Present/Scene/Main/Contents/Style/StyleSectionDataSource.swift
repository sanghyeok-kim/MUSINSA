//
//  StyleSectionViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import UIKit

final class StyleSectionDataSource: SectionDataSource {
    
    private lazy var layoutItem: NSCollectionLayoutItem = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / 2),
            heightDimension: .fractionalHeight(1)
        )
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
        layoutItem.contentInsets =  NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        return layoutItem
    }()
    
    private lazy var layoutGroup: NSCollectionLayoutGroup = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.75)
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: layoutSize,
            subitems: [layoutItem]
        )
        return layoutGroup
    }()
    
    private lazy var supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.05)
        )
        
        let layoutHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let layoutFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        return [layoutHeader, layoutFooter]
    }()
    
    lazy var layoutSection: NSCollectionLayoutSection = {
        let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)
        sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        sectionLayout.boundarySupplementaryItems = supplementaryItems
        return sectionLayout
    }()
    
    var itemCount: Int {
        return sectionDataCount
    }
    
    private var sectionDataCount = 0
    let disposeBag = DisposeBag()
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StyleViewCell.identifier,
            for: indexPath
        ) as? StyleViewCell else { return UICollectionViewCell() }
        
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

extension StyleSectionDataSource: View {
    func bind(to viewModel: StyleSectionDataSourceViewModel) {
        defer { viewModel.action.loadData.accept(()) }
        
        viewModel.state.itemCount
            .bind(onNext: { [weak self] count in
                self?.sectionDataCount = count
            })
            .disposed(by: disposeBag)
    }
}

extension StyleSectionDataSource: HeaderUsable {
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

extension StyleSectionDataSource: FooterUsable {
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
