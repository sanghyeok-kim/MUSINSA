//
//  BannerSectionDataSource.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import UIKit

protocol BannerPageCountable {
    func appendPageCountView(to layoutSection: NSCollectionLayoutSection)
}

extension BannerPageCountable {
    func dequeuePageCountSupplementaryView(_ collectionView: UICollectionView,
                                           at indexPath: IndexPath,
                                           with viewModel: PageCountViewBindable?) -> UICollectionReusableView {
        guard let pageCountView = collectionView.dequeueReusableSupplementaryView(
            ofKind: PageCountSupplementaryView.elementaryKind,
            withReuseIdentifier: PageCountSupplementaryView.reuseIdentifier,
            for: indexPath
        ) as? PageCountSupplementaryView else { return UICollectionReusableView() }
        viewModel?.bindPageCountViewModel(for: pageCountView)
        return pageCountView
    }
}

final class BannerSectionDataSource: SectionDataSource {
    
    private lazy var layoutItem: NSCollectionLayoutItem = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
        return layoutItem
    }()
    
    private lazy var layoutGroup: NSCollectionLayoutGroup = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: layoutSize,
            subitems: [layoutItem]
        )
        return layoutGroup
    }()
    
    lazy var layoutSection: NSCollectionLayoutSection = {
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        appendPageCountView(to: layoutSection)
        layoutSection.orthogonalScrollingBehavior = .paging
        return layoutSection
    }()
    
    private var sectionDataCount = 0
    
    var itemCount: Int {
        return sectionDataCount
    }
    
    let disposeBag = DisposeBag()
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerViewCell.identifier,
            for: indexPath
        ) as? BannerViewCell else { return UICollectionViewCell() }
        
        viewModel?.bindCellViewModel(for: cell, at: indexPath.item)
        return cell
    }
    
    func dequeueSupplementaryView(_ collectionView: UICollectionView,
                                  viewForSupplementaryElementOfKind kind: String,
                                  at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case PageCountSupplementaryView.elementaryKind:
            return dequeuePageCountSupplementaryView(collectionView, at: indexPath, with: viewModel)
        default:
            return UICollectionReusableView()
        }
    }
}

extension BannerSectionDataSource: View {
    func bind(to viewModel: BannerSectionDataSourceViewModel) {
        viewModel.state.itemCount
            .bind(onNext: { [weak self] count in
                self?.sectionDataCount = count
            })
            .disposed(by: disposeBag)
        
        viewModel.action.loadData.accept(())
    }
}

extension BannerSectionDataSource: BannerPageCountable {
    func appendPageCountView(to layoutSection: NSCollectionLayoutSection) {
        let pageCountLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(50),
            heightDimension: .absolute(25)
        )
        
        let pageCountLayoutAnchor = NSCollectionLayoutAnchor(
            edges: [.trailing, .bottom],
            fractionalOffset: CGPoint(x: -0.5, y: -1)
        )
        
        let pageCountSupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: pageCountLayoutSize,
            elementKind: PageCountSupplementaryView.elementaryKind,
            containerAnchor: pageCountLayoutAnchor
        )
        
        layoutSection.boundarySupplementaryItems.append(pageCountSupplementaryItem)
    }
}
