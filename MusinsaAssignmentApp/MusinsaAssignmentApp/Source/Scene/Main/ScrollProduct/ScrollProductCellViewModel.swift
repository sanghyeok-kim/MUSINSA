//
//  ScrollProductCellViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import Foundation

class ScrollProductCellViewModel: ViewModel {
    struct Action {
        let loadProduct = Observable<Void>()
    }
    
    struct State {
        let loadedProductDTO = Observable<ProductDTO>()
        //let loadedThumbnailUrlString = Observable<String>()
    }
    
    let action = Action()
    let state = State()
    
    init(product: Product) {
        self.action.loadProduct.bind { [weak self] in
            guard let self = self else { return }
            self.state.loadedProductDTO.accept(ProductDTO(product: product))
        }
    }
}
