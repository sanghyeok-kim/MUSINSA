//
//  ScrollProductCellViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import Foundation

class ScrollProductCellViewModel: ViewModel {
    
    struct Action {
        let loadProduct = PublishRelay<Void>()
        let cellTapped = PublishRelay<Void>()
    }
    
    struct State {
        let loadedProductDTO = PublishRelay<ProductEntity>()
        let tappedProduct = PublishRelay<Tappable>()
    }
    
    let action = Action()
    let state = State()
    
    private let disposeBag = DisposeBag()
    
    init(productEntity: ProductEntity) {
        self.action.loadProduct.bind { [weak self] in
            self?.state.loadedProductDTO.accept(productEntity)
        }
        .disposed(by: disposeBag)
        
        self.action.cellTapped.bind { [weak self] in
            self?.state.tappedProduct.accept(productEntity)
        }
        .disposed(by: disposeBag)
    }
}
