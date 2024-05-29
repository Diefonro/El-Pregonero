//
//  NewsListScreenVC.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 24/05/2024.
//

import UIKit

class NewsListScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "NewsListScreen"
    static var identifier = "NewsListScreenVC"
    
    var viewModel: NewsScreenViewModel?
    var newsCoordinator: NewsScreenCoordinator?
    
    @IBOutlet weak var collectionContainerView: UIView!
    
    private lazy var collectionView: UICollectionView? = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel?.getNews {
            print("hi :D")
        }
        
//        viewModel?.getShows {
//            DispatchQueue.main.async {
//                self.collectionView!.reloadSections(IndexSet(integer: 0))
//            }
//        }
        
        viewModel?.getSports {
            DispatchQueue.main.async {
                self.collectionView!.reloadSections(IndexSet(integer: 3))
                print("Data matches available :D, \(DataManager.matchesData.count)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "News List"
        self.newsCoordinator?.enableDragPopGesture()
    }
    
    func setViewModel(viewModel: NewsScreenViewModel) {
        self.viewModel = viewModel
    }
    
    func setCoordinator(coordinator: NewsScreenCoordinator?) {
        self.newsCoordinator = coordinator
    }
    
    func setupCollectionView() {
        //MARK: Delegates assingment
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        //MARK: CollectionView size setup.
        collectionContainerView.addSubview(collectionView!)
        collectionView!.frame = collectionContainerView.bounds
        collectionView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: collectionContainerView.topAnchor),
            collectionView!.leadingAnchor.constraint(equalTo: collectionContainerView.leadingAnchor),
            collectionView!.trailingAnchor.constraint(equalTo: collectionContainerView.trailingAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: collectionContainerView.bottomAnchor)
        ])
        
        //MARK: Cells registration
        collectionView!.register(UINib(nibName: ProgramCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ProgramCell.reuseIdentifier)
        collectionView!.register(UINib(nibName: ArticlesContainerCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ArticlesContainerCell.reuseIdentifier)
        collectionView!.register(UINib(nibName: NewsSectionCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: NewsSectionCell.reuseIdentifier)
        collectionView!.register(UINib(nibName: SportsHighlightsCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SportsHighlightsCell.reuseIdentifier)
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int, layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                // Item size
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Spacing between items
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
                
                // Group size
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .estimated(250))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 20, bottom: 40, trailing: 0)
                
                // Header
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading)
                header.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0)
                
                section.boundarySupplementaryItems = [header]
                
                return section
            case 1:
                // Item size
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Spacing between items
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 10)
                
                // Group size
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(500))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 0)
                
                // Header
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading)
                section.boundarySupplementaryItems = [header]
                return section
                
            case 2:
                // Item size
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Spacing between items
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
                
                // Group size
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 40, trailing: 10)
                
                // Header
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading)
                section.boundarySupplementaryItems = [header]
                return section
                
            case 3:
                // Item size
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Spacing between items
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
                
                // Group size
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(500))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 40, trailing: 0)
                
                // Header
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading)
                section.boundarySupplementaryItems = [header]
                return section
                
                
            default:
                print("Failed to layout section")
                // Item size
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Spacing between items
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
                
                // Group size
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 40, trailing: 0)
                
                return section
            }
            
        }
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
    }
    
}
