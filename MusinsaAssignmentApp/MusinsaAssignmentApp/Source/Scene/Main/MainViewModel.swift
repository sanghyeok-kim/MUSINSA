//
//  MainViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/15.
//

import UIKit

class MainViewModel: ViewModel {
    @NetworkInjector(keypath: \.mainRepository)
    private var networkManager: MainRepositoryProtocol
    
    struct Action {
        let loadData = Observable<Void>()
    }
    
    struct State {
        let loadedData = Observable<Entity>()
        let loadedSectionViewModels = Observable<[SectionViewModel]>()
    }
    
    let action = Action()
    let state = State()
    
    init() {
        action.loadData
            .bind { [weak self] in
                guard let self = self else { return }
                self.networkManager.requestDataFromBundle { response in
                    switch response {
                    case .success(let entity):
                        self.state.loadedData.accept(entity)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        
        state.loadedData
            .bind { [weak self] entity in
                guard let self = self else { return }
                let sectionViewModels: [SectionViewModel] = entity.data
                    .map { entity -> SectionViewModel in
                        switch entity.contents.type {
                        case .banner:
                            let model = BannerSectionViewModel(datum: entity)
                            return model
                        case .grid:
                            let model = GridProductSectionViewModel(datum: entity)
                            return model
                        case .scroll:
                            let model = ScrollProductSectionViewModel(datum: entity)
                            return model
                        case .style:
                            let model = StyleSectionViewModel(datum: entity)
                            return model
                        }
                    }
                self.state.loadedSectionViewModels.accept(sectionViewModels)
            }
    }
    
}
