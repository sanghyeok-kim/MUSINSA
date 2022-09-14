//
//  MainViewController.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/14.

import UIKit

class MainViewController: UIViewController, View {
    
    private lazy var collectionViewDataSource = MainCollectionViewDataSource()
    private lazy var collectionView: UICollectionView = {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        let layout = UICollectionViewCompositionalLayout(sectionProvider: collectionViewDataSource.sectionProvider,
                                                         configuration: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(BannerViewCell.self, forCellWithReuseIdentifier: BannerViewCell.identifier)
        collectionView.register(GridProductViewCell.self, forCellWithReuseIdentifier: GridProductViewCell.identifier)
        collectionView.register(ScrollProductViewCell.self, forCellWithReuseIdentifier: ScrollProductViewCell.identifier)
        collectionView.register(StyleViewCell.self, forCellWithReuseIdentifier: StyleViewCell.identifier)
        
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.register(FooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: FooterView.reuseIdentifier)
        collectionView.register(PageCountSupplementaryView.self,
                                forSupplementaryViewOfKind: PageCountSupplementaryView.elementaryKind,
                                withReuseIdentifier: PageCountSupplementaryView.reuseIdentifier)
        
        collectionView.dataSource = collectionViewDataSource
        collectionView.backgroundColor = .systemGray3
        return collectionView
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCollectionView()
        viewModel?.action.loadData.accept(())
    }
    
    func bind(to viewModel: MainViewModel) {
        viewModel.state.loadedSectionDataSourceViewModels
            .bind { [weak self] sectionDataSourceViewModels in
                self?.collectionViewDataSource.append(sectionDataSourceViewModels)
//                self.collectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        viewModel.action.openURL.bind { url in
            print(url)
            UIApplication.shared.open(url)
        }
        .disposed(by: disposeBag)
        
//        collectionView.reloadItems(at: <#T##[IndexPath]#>)
    }
}

// MARK: - View Layout

private extension MainViewController {
    func layoutCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
