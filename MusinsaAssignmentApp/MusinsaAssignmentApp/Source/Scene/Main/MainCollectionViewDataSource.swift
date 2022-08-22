//
//  MainCollectionViewDataSource.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/14.
//

import UIKit

final class MainCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private var sectionViewModels: [SectionViewModel] = []
    
    func appendSection(viewModels: [SectionViewModel]) {
        sectionViewModels.append(contentsOf: viewModels)
    }
    
    //Section안의 item 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionItmeCount = sectionViewModels[section].getItemCount()
        return sectionItmeCount
    }
    
    //Section의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let sectionCount = sectionViewModels.count
        return sectionCount
    }
    
    //각 Section별 DataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionDataSource = sectionViewModels[indexPath.section].dequeueReusableCell(collectionView, cellForItemAt: indexPath)
        return sectionDataSource
    }
    
    //각 Section별 CompositionalLayout
    func sectionProvider(_ section: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let sectionLayout = sectionViewModels[section].sectionProvider(section, env: env)
        return sectionLayout
    }
    
    //각 Section별 SupplementaryView
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let supplementaryView = sectionViewModels[indexPath.section].collectionView(collectionView,
                                                                                viewForSupplementaryElementOfKind: kind,
                                                                                at: indexPath)
        return supplementaryView
    }
}
