//
//  StyleSectionDataSourceViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/28.
//

import Foundation

final class StyleSectionDataSourceViewModel: SectionDataSourceViewModel, ViewModel {
    
    struct Action {
        let loadData = PublishRelay<Void>()
    }
    
    struct State {
        let itemCount = PublishRelay<Int>()
        let tappedCell = PublishRelay<Tappable>()
        let headerViewModel: HeaderViewModel?
        let footerViewModel: FooterViewModel?
    }
    
    let action = Action()
    let state: State
    
    var sectionEntity: SectionEntity
    private let disposeBag = DisposeBag()
    private var cellViewModels: [StyleCellViewModel] = []
    
    init(sectionEntity: SectionEntity) {
        self.sectionEntity = sectionEntity
        
        let headerViewModel = HeaderViewModel(header: sectionEntity.header)
        let footerViewModel = FooterViewModel(footer: sectionEntity.footer)
        state = State(headerViewModel: headerViewModel, footerViewModel: footerViewModel)
        
        cellViewModels = sectionEntity.contentsItems
            .compactMap { $0 as? StyleEntity }
            .map { StyleCellViewModel(styleEntity: $0) }
        
        action.loadData.bind { [weak self] in
            self?.state.itemCount.accept(sectionEntity.contentsItemCount)
        }
        .disposed(by: disposeBag)
        
        cellViewModels.forEach { cellViewModel in
            cellViewModel.state.tappedProduct.bind { [weak self] product in
                self?.state.tappedCell.accept(product)
            }
            .disposed(by: disposeBag)
        }
    }
    
    func bindCellViewModel<T>(for cellView: T, at index: Int) where T : View {
        cellView.viewModel = cellViewModels[index] as? T.ViewModel
    }
}

extension StyleSectionDataSourceViewModel: HeaderBindable {
    func bindHeaderViewModel<T>(for headerView: T) where T : View {
        headerView.viewModel = state.headerViewModel as? T.ViewModel
    }
}

extension StyleSectionDataSourceViewModel: FooterBindable {
    func bindFooterViewModel<T>(for footerView: T) where T : View {
        footerView.viewModel = state.footerViewModel as? T.ViewModel
    }
}
