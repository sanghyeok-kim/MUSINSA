//
//  GridProductCellViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import Foundation

final class GridProductCellViewModel: ViewModel {
    
    struct Action {
        let loadProduct = PublishRelay<Void>()
        let cellTapped = PublishRelay<Void>()
    }
    
    struct State {
        let loadedProduct = PublishRelay<ProductDTO>()
        let tappedProduct = PublishRelay<Linkable>()
    }
    
    let action = Action()
    let state = State()
    
    private let disposeBag = DisposeBag()
    
    init(product: Product) {
        self.action.loadProduct.bind { [weak self] in
            self?.state.loadedProduct.accept(ProductDTO(product: product))
        }
        .disposed(by: disposeBag)
        
        self.action.cellTapped.bind { [weak self] in
            self?.state.tappedProduct.accept(product)
        }
        .disposed(by: disposeBag)
    }
}
