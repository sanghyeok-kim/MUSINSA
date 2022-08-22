//
//  GridProductCellViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import Foundation

class GridProductCellViewModel: ViewModel {
    struct Action {
        let loadProduct = Observable<Void>()
    }
    
    struct State {
        let loadedProduct = Observable<ProductDTO>()
    }
    
    let action = Action()
    let state = State()
    
    init(product: Product) {
        self.action.loadProduct.bind { [weak self] in
            guard let self = self else { return }
            self.state.loadedProduct.accept(ProductDTO(product: product))
        }
    }
}
