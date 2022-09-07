//
//  HeaderViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/22.
//

import Foundation

final class HeaderViewModel: ViewModel {
    
    struct Action {
        let loadData = PublishRelay<Void>()
        let seeAllButtonTapped = PublishRelay<Void>()
    }
    
    struct State {
        let loadedData = PublishRelay<HeaderEntity>()
    }
    
    let action = Action()
    let state = State()
    
    private let disposeBag = DisposeBag()
    
    init?(header: HeaderEntity?) {
        guard let header = header else { return }
        action.loadData.bind { [weak self] in
            self?.state.loadedData.accept(header)
        }
        .disposed(by: disposeBag)
    }
}
