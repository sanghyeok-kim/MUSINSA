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
        let loadedStyleDTO = PublishRelay<StyleDTO>()
        let tappedProduct = PublishRelay<Linkable>()
    }
    
    let action = Action()
    let state = State()
    
    private let disposeBag = DisposeBag()
    
    init(style: Style) {
        self.action.loadStyle.bind { [weak self] in
            self?.state.loadedStyleDTO.accept(StyleDTO(style: style))
        }
        .disposed(by: disposeBag)
        
        self.action.cellTapped.bind { [weak self] in
            self?.state.tappedProduct.accept(style)
        }
        .disposed(by: disposeBag)
    }
    
}
