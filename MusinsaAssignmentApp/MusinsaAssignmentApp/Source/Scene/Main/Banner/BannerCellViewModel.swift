//
//  BannerCellViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/17.
//

import Foundation

class BannerCellViewModel: ViewModel {
    struct Action {
        let loadBanner = Observable<Void>()
    }
    
    struct State {
        let loadedBanner = Observable<BannerDTO>()
    }
    
    let action = Action()
    let state = State()
    
    init(banner: Banner) {
        self.action.loadBanner.bind { [weak self] in
            guard let self = self else { return }
            self.state.loadedBanner.accept(BannerDTO(banner: banner))
        }
    }
}
