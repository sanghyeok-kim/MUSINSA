//
//  ScrollProductSectionViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import UIKit

final class ScrollProductSectionViewModel: SectionViewModel {
    private let datum: Entity.Datum
    
    init(datum: Entity.Datum) {
        self.datum = datum
    }
    
    func getItemCount() -> Int {
        return datum.contents.products?.count ?? 0
    }
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrollProductViewCell.identifier, for: indexPath) as? ScrollProductViewCell,
              let products = datum.contents.products else {
            return UICollectionViewCell()
        }
        
        let cellViewModel = ScrollProductCellViewModel(product: products[indexPath.item])
        cell.viewModel = cellViewModel
        return cell
    }
    
    func sectionProvider(_ section: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / 3),
            heightDimension: .fractionalWidth(1 / 2)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(
            top: 0,
            leading: 2,
            bottom: 0,
            trailing: 2
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1 / 2)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100.0)
        )
        
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let footerElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        let sectionLayout = NSCollectionLayoutSection(group: group)
//        sectionLayout.boundarySupplementaryItems = [headerElement, footerElement]
        sectionLayout.orthogonalScrollingBehavior = .continuous
        sectionLayout.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        return sectionLayout
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath) as? HeaderView else { return UICollectionReusableView() }
//            supplementaryView.setTitleLabel(text: "\(datum.header?.title)")
            return supplementaryView
        case UICollectionView.elementKindSectionFooter:
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FooterView.reuseIdentifier,
                for: indexPath) as? FooterView else { return UICollectionReusableView() }
//            supplementaryView.setTitleLabel(text: "\(datum.footer?.title)")
            return supplementaryView
        default:
            return UICollectionReusableView()
        }
        
//        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
//            ofKind: kind,
//            withReuseIdentifier: HeaderView.reuseIdentifier,
//            for: indexPath) as? HeaderView else { return UICollectionReusableView() }
//
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            supplementaryView.setTitleLabel(text: "\(datum.header?.title)")
//        case UICollectionView.elementKindSectionFooter:
//            supplementaryView.setTitleLabel(text: "\(datum.footer?.title)")
//        default:
//            break
//        }
//
//        return supplementaryView
    }
}
