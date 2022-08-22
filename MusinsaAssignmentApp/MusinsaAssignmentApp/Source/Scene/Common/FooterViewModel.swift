//
//  FooterViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/22.
//

import Foundation

final class FooterViewModel: ViewModel {
    struct Action {
        let loadFooter = Observable<Void>()
    }
    
    struct State {
        let loadedFooter = Observable<FooterDTO>()
    }
    
    let action = Action()
    let state = State()
    
    init(footer: Footer) {
        action.loadFooter.bind { [weak self] in
            guard let self = self else { return }
//            self.loadedFooter.accept(FooterDTO(footer: footer))
        }
    }
}
