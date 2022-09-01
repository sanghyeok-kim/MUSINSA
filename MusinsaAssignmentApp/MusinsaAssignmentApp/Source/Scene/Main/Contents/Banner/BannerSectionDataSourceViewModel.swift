//
//  BannerSectionDataSourceViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/28.
//

import Foundation

final class BannerSectionDataSourceViewModel: SectionDataSourceViewModel, ViewModel {
    
    var sectionData: Entity.SectionData
    
    struct Action {
        let loadData = PublishRelay<Void>()
    }
    
    struct State {
        let itemCount = PublishRelay<Int>()
        var pageCountViewModel: PageCountSupplementaryViewModel?
    }
    
    private let disposeBag = DisposeBag()
    private var cellViewModels: [BannerCellViewModel]
    
    let action = Action()
    let state = State()
    
    init(sectionData: Entity.SectionData) {
        self.sectionData = sectionData
        
        cellViewModels = sectionData.contents.banners!.map { banner in
            BannerCellViewModel(banner: banner)
        }
        
        action.loadData.bind { [weak self] in
            self?.state.itemCount.accept(sectionData.contents.banners!.count)
        }
        .disposed(by: disposeBag)
    }
    
    func bindCellViewModel<T>(for cellView: T, at index: Int) where T : View {
        cellView.viewModel = cellViewModels[index] as? T.ViewModel
    }
}

extension BannerSectionDataSourceViewModel: PageCountViewBindable {
    func bindPageCountViewModel<T>(for pageCountView: T) where T : View {
        pageCountView.viewModel = state.pageCountViewModel as? T.ViewModel
    }
}
