//
//  BannerSectionViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import UIKit

final class BannerSectionViewModel: SectionViewModel {
    private let datum: Entity.Datum
    
    init(datum: Entity.Datum) {
        self.datum = datum
    }
    
    func getItemCount() -> Int {
        return datum.contents.banners?.count ?? 0
    }
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerViewCell.identifier, for: indexPath) as? BannerViewCell,
              let banners = datum.contents.banners else {
            return UICollectionViewCell()
        }
        
        let cellViewModel = BannerCellViewModel(banner: banners[indexPath.item])
        cell.viewModel = cellViewModel
        return cell
    }
    
    func sectionProvider(_ section: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let pageCountElementSize = NSCollectionLayoutSize(
            widthDimension: .absolute(50),
            heightDimension: .absolute(25)
        )
        
        let anchor = NSCollectionLayoutAnchor(edges: [.trailing, .bottom], fractionalOffset: CGPoint(x: -0.5, y: -1))
        //franctional -> 자기 자신의 container 뷰를 기준으로 한 비율
        //x -> 자기 자신의 height 값에서 몇 배수 만큼 x축으로 이동할지
        //y -> 자기 자신의 width 값에서 몇 배수 만큼 y축으로 이동할지
        
        let pageCountElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: pageCountElementSize,
            elementKind: PageCountSupplementaryView.elementaryKind,
            containerAnchor: anchor
        )
        
        let sectionLayout = NSCollectionLayoutSection(group: group)
        sectionLayout.boundarySupplementaryItems = [pageCountElement]
        sectionLayout.orthogonalScrollingBehavior = .paging
        return sectionLayout
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case PageCountSupplementaryView.elementaryKind:
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: PageCountSupplementaryView.reuseIdentifier,
                for: indexPath) as? PageCountSupplementaryView else { return UICollectionReusableView() }
            return supplementaryView
        default:
            return UICollectionReusableView()
        }
    }
}
