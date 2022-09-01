//
//  BannerCellViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import Foundation

class BannerCellViewModel: ViewModel {
    
    struct Action {
        let loadBanner = PublishRelay<Void>()
        let cellTapped = PublishRelay<Void>()
    }
    
    struct State {
        let loadedBanner = PublishRelay<BannerDTO>()
    }
    
    let action = Action()
    let state = State()
    
    private let disposeBag = DisposeBag()
    
    init(banner: Banner) {
        action.loadBanner.bind { [weak self] in
            self?.state.loadedBanner.accept(BannerDTO(banner: banner))
        }
        .disposed(by: disposeBag)
        
        action.cellTapped.bind { [weak self] in
        }
        .disposed(by: disposeBag)
    }
}
