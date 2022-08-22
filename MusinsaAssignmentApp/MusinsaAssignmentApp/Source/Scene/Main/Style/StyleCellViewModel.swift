//
//  StyleCellViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import Foundation

class StyleCellViewModel: ViewModel {
    struct Action {
        let loadStyle = Observable<Void>()
    }
    
    struct State {
        let loadedStyleDTO = Observable<StyleDTO>()
    }
    
    let action = Action()
    let state = State()
    
    init(style: Style) {
        self.action.loadStyle.bind { [weak self] in
            guard let self = self else { return }
            self.state.loadedStyleDTO.accept(StyleDTO(style: style))
        }
    }
}
