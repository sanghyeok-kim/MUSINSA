//
//  SectionViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/22.
//

import UIKit

protocol SectionViewModel {
    func getItemCount() -> Int
    
    func dequeueReusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func sectionProvider(_ section: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView
}
