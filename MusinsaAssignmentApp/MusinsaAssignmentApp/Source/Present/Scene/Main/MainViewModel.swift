//
//  MainViewModel.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/15.
//

import Foundation

final class MainViewModel: ViewModel {
    
    @NetworkInjector(keypath: \.mainRepository)
    private var networkManager: MainRepositoryProtocol
    
    struct Action {
        let loadData = PublishRelay<Void>()
    }
    
    struct State {
        let loadedData = PublishRelay<MusinsaEntity>()
        let loadedSectionDataSourceViewModels = PublishRelay<[SectionDataSourceViewModel]>()
        let openURL = PublishRelay<URL>()
        let reloadItems = PublishRelay<Range<Int>>()
    }
    
    let action = Action()
    let state = State()
    
    private let disposeBag = DisposeBag()
    
    init() {
        action.loadData.bind { [weak self] in
            self?.networkManager.requestDataFromBundle { response in
                switch response {
                case .success(let entity):
                    self?.state.loadedData.accept(entity)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        .disposed(by: disposeBag)
        
        state.loadedData.bind { [weak self] entity in
            let sectionDataSources = entity.data.map { entity -> SectionDataSourceViewModel in
                switch entity.contentsType {
                case .banner:
                    let viewModel = BannerSectionDataSourceViewModel(sectionEntity: entity)
                    self?.bindBannerSection(to: viewModel)
                    return viewModel
                case .grid:
                    let viewModel = GridProductSectionDataSourceViewModel(sectionEntity: entity)
                    self?.bindGridProductSection(to: viewModel)
                    return viewModel
                case .scroll:
                    let viewModel = ScrollProductSectionDataSourceViewModel(sectionEntity: entity)
                    self?.bindScrollProductSection(to: viewModel)
                    return viewModel
                case .style:
                    let viewModel = StyleSectionDataSourceViewModel(sectionEntity: entity)
                    self?.bindStyleSection(to: viewModel)
                    return viewModel
                }
            }
            self?.state.loadedSectionDataSourceViewModels.accept(sectionDataSources)
        }
        .disposed(by: disposeBag)
    }
    
    private func bindBannerSection(to viewModel: BannerSectionDataSourceViewModel) {
            bindCellTapped(to: viewModel.state.tappedCell)
    }
    
    private func bindGridProductSection(to viewModel: GridProductSectionDataSourceViewModel) {
            bindCellTapped(to: viewModel.state.tappedCell)
    }
    
    private func bindScrollProductSection(to viewModel: ScrollProductSectionDataSourceViewModel) {
            bindCellTapped(to: viewModel.state.tappedCell)
    }
    
    private func bindStyleSection(to viewModel: StyleSectionDataSourceViewModel) {
            bindCellTapped(to: viewModel.state.tappedCell)
    }
    
    private func bindCellTapped(to observable: PublishRelay<Tappable>) {
        observable.bind { [weak self] tappedCell in
            guard let url = tappedCell.linkUrl else { return }
            self?.state.openURL.accept(url)
        }
        .disposed(by: disposeBag)
    }
    
    private func reloadItems(at observable: PublishRelay<Void>) {
        observable.bind { [weak self] in
            self?.state.reloadItems.accept(6..<8)
        }
        .disposed(by: disposeBag)
    }
}
