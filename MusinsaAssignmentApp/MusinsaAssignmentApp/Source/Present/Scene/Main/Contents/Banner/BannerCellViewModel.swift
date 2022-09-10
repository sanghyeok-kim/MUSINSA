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
        let loadedBanner = PublishRelay<BannerEntity>()
        let tappedBanner = PublishRelay<Tappable>()
    }
    
    let action = Action()
    let state = State()
    
    private let disposeBag = DisposeBag()
    
    init(bannerEntity: BannerEntity) {
        action.loadBanner.bind { [weak self] in
            self?.state.loadedBanner.accept(bannerEntity)
        }
        .disposed(by: disposeBag)
        
        action.cellTapped.bind { [weak self] in
            self?.state.tappedBanner.accept(bannerEntity)
        }
        .disposed(by: disposeBag)
    }
}
