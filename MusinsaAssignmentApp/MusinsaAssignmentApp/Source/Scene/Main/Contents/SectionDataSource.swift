//
//  SectionDataSource.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/22.
//

import UIKit

protocol SectionDataSource {
    var layoutSection: NSCollectionLayoutSection { get }
    var itemCount: Int { get }
    
    func dequeueReusableCell(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func dequeueSupplementaryView(_ collectionView: UICollectionView,
                           viewForSupplementaryElementOfKind kind: String,
                           at indexPath: IndexPath) -> UICollectionReusableView
}
