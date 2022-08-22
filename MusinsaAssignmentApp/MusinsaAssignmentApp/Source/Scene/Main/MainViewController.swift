//
//  MainViewController.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/07/14.
//

import UIKit

class MainViewController: UIViewController, View {
    private lazy var collectionViewDataSource = MainCollectionViewDataSource()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: collectionViewDataSource.sectionProvider)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCollectionView()
        viewModel?.action.loadData.accept(())
    }
    
    func bind(to viewModel: MainViewModel) {
        viewModel.state.loadedSectionViewModels
            .bind { [weak self] sectionViewModels in
                guard let self = self else { return }
                self.collectionViewDataSource.appendSection(viewModels: sectionViewModels)
//                self.collectionView.reloadData()
            }
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
