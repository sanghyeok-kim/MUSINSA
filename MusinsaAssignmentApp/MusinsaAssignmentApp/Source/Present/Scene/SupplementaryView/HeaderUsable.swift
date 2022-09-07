//
//  HeaderUsable.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/31.
//

import UIKit

protocol HeaderUsable {
    func appendHeader(to layoutSection: NSCollectionLayoutSection)
}

extension HeaderUsable {
    func dequeueReusableHeaderView(_ collectionView: UICollectionView,
                                   at indexPath: IndexPath,
                                   with viewModel: HeaderBindable?) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.reuseIdentifier,
            for: indexPath
        ) as? HeaderView else { return UICollectionReusableView() }
        viewModel?.bindHeaderViewModel(for: headerView)
        return headerView
    }
}
