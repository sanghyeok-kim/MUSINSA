//
//  GridProductSectionDataSourceViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/28.
//

import Foundation

final class GridProductSectionDataSourceViewModel: SectionDataSourceViewModel, ViewModel {
    
    struct Action {
        let loadData = PublishRelay<Void>()
        let headerSeeAllButtonTapped = PublishRelay<Void>()
    }
    
    struct State {
        let itemCount = PublishRelay<Int>()
        let tappedCell = PublishRelay<Linkable>()
        let headerViewModel: HeaderViewModel?
        let footerViewModel: FooterViewModel?
    }
    
    let action = Action()
    let state: State
    
    var sectionData: Entity.SectionData
    private let disposeBag = DisposeBag()
    private var cellViewModels: [GridProductCellViewModel] = []
    
    init(sectionData: Entity.SectionData) {
        self.sectionData = sectionData
        
        let headerViewModel = HeaderViewModel(header: sectionData.header)
        let footerViewModel = FooterViewModel(footer: sectionData.footer)
        state = State(headerViewModel: headerViewModel, footerViewModel: footerViewModel)
        
        headerViewModel?.action.seeAllButtonTapped
            .bind(onNext: { [weak self] in
                self?.action.headerSeeAllButtonTapped.accept(())
            })
            .disposed(by: disposeBag)
        
        cellViewModels = sectionData.contents.products!.map { product in
            GridProductCellViewModel(product: product)
        }
        
        action.loadData.bind { [weak self] in
            self?.state.itemCount.accept(sectionData.contents.products!.count)
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

extension GridProductSectionDataSourceViewModel: HeaderBindable {
    func bindHeaderViewModel<T>(for headerView: T) where T : View {
        headerView.viewModel = state.headerViewModel as? T.ViewModel
    }
}

extension GridProductSectionDataSourceViewModel: FooterBindable {
    func bindFooterViewModel<T>(for footerView: T) where T : View {
        footerView.viewModel = state.footerViewModel as? T.ViewModel
    }
}
