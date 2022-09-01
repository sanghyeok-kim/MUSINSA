//
//  MainCollectionViewDataSource.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/14.
//

import UIKit

final class MainCollectionViewDataSource: NSObject {
    
    private var sectionDataSources: [SectionDataSource] = []
    
    func append(_ sectionDataSourceViewModels: [SectionDataSourceViewModel]) {
        sectionDataSourceViewModels.forEach { sectionDataSourceViewModel in
            switch sectionDataSourceViewModel.sectionData.contents.type { //TODO: dot level 낮추기
            case .banner:
                let sectionDataSource = BannerSectionDataSource()
                sectionDataSource.viewModel = sectionDataSourceViewModel as? BannerSectionDataSourceViewModel
                sectionDataSources.append(sectionDataSource)
            case .grid:
                let sectionDataSource = GridProductSectionDataSource()
                sectionDataSource.viewModel = sectionDataSourceViewModel as? GridProductSectionDataSourceViewModel
                sectionDataSources.append(sectionDataSource)
            case .scroll:
                let sectionDataSource = ScrollProductSectionDataSource()
                sectionDataSource.viewModel = sectionDataSourceViewModel as? ScrollProductSectionDataSourceViewModel
                sectionDataSources.append(sectionDataSource)
            case .style:
                let sectionDataSource = StyleSectionDataSource()
                sectionDataSource.viewModel = sectionDataSourceViewModel as? StyleSectionDataSourceViewModel
                sectionDataSources.append(sectionDataSource)
            }
        }
    }
    
    //각 Section별 CompositionalLayout
    func sectionProvider(_ section: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let sectionLayout = sectionDataSources[section].layoutSection
        return sectionLayout
    }
}

extension MainCollectionViewDataSource: UICollectionViewDataSource {
    
    //Section의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let sectionCount = sectionDataSources.count
        return sectionCount
    }
    
    //Section안의 item 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionItemCount = sectionDataSources[section].itemCount
        return sectionItemCount
    }
    
    //DataSource의 각 Section별 Item -> 여기서는 Item이 SectionDataSource를 의미
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionDataSource = sectionDataSources[indexPath.section].dequeueReusableCell(collectionView, cellForItemAt: indexPath)
        return sectionDataSource
    }
    
    //각 Section별 SupplementaryView
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        let supplementaryView = sectionDataSources[indexPath.section].dequeueSupplementaryView(
            collectionView,
            viewForSupplementaryElementOfKind: kind,
            at: indexPath
        )
        return supplementaryView
    }
}
