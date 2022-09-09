//
//  StyleCellViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import Foundation

class StyleCellViewModel: ViewModel {
    
    struct Action {
        let loadStyle = PublishRelay<Void>()
        let cellTapped = PublishRelay<Void>()
    }
    
    struct State {
        let loadedStyleDTO = PublishRelay<StyleEntity>()
        let tappedProduct = PublishRelay<Tappable>()
    }
    
    let action = Action()
    let state = State()
    
    private let disposeBag = DisposeBag()
    
    init(styleEntity: StyleEntity) {
        self.action.loadStyle.bind { [weak self] in
            self?.state.loadedStyleDTO.accept(styleEntity)
        }
        .disposed(by: disposeBag)
        
        self.action.cellTapped.bind { [weak self] in
            self?.state.tappedProduct.accept(styleEntity)
        }
        .disposed(by: disposeBag)
    }
    
}
