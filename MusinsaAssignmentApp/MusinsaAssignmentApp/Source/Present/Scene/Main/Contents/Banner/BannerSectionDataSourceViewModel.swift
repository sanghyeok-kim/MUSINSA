//
//  BannerSectionDataSourceViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/28.
//

import Foundation

final class BannerSectionDataSourceViewModel: SectionDataSourceViewModel, ViewModel {
    
    var sectionEntity: SectionEntity
    
    struct Action {
        let loadData = PublishRelay<Void>()
    }
    
    struct State {
        let itemCount = PublishRelay<Int>()
        let tappedCell = PublishRelay<Tappable>()
        var pageCountViewModel: PageCountSupplementaryViewModel?
    }
    
    private let disposeBag = DisposeBag()
    private var cellViewModels: [BannerCellViewModel]
    
    let action = Action()
    let state = State()
    
    init(sectionEntity: SectionEntity) {
        self.sectionEntity = sectionEntity
        
        cellViewModels = sectionEntity.contentsItems
            .compactMap{ $0 as? BannerEntity }
            .map { BannerCellViewModel(bannerEntity: $0) }
        
        action.loadData.bind { [weak self] in
            self?.state.itemCount.accept(sectionEntity.contentsItemCount)
        }
        .disposed(by: disposeBag)
        
        cellViewModels.forEach { cellViewModel in
            cellViewModel.state.tappedBanner.bind { [weak self] banner in
                self?.state.tappedCell.accept(banner)
            }
            .disposed(by: disposeBag)
        }
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
