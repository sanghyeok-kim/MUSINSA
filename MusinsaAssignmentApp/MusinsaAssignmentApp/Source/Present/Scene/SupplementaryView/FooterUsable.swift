//
//  FooterUsable.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/31.
//

import UIKit

protocol FooterUsable {
    func appendFooter(to layoutSection: NSCollectionLayoutSection)
}

extension FooterUsable {
    func dequeueReusableFooterView(_ collectionView: UICollectionView,
                                   at indexPath: IndexPath,
                                   with viewModel: FooterBindable?) -> UICollectionReusableView {
        guard let footerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: FooterView.reuseIdentifier,
            for: indexPath
        ) as? FooterView else { return UICollectionReusableView() }
        viewModel?.bindFooterViewModel(for: footerView)
        return footerView
    }
}
