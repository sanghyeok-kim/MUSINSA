//
//  FooterViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/22.
//

import Foundation

final class FooterViewModel: ViewModel {
    
    struct Action {
        let loadFooter = PublishRelay<Void>()
    }
    
    struct State {
        let loadedFooter = PublishRelay<FooterEntity>()
    }
    
    let action = Action()
    let state = State()
    private let disposeBag = DisposeBag()
    
    init?(footer: FooterEntity?) {
        guard let footer = footer else { return }

        action.loadFooter.bind { [weak self] in
            self?.state.loadedFooter.accept(footer)
        }
        .disposed(by: disposeBag)
    }
}
