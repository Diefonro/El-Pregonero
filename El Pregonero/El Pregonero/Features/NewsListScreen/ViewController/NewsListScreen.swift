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
    
    @IBOutlet weak var collectionContainerView: UIView!
    
    private lazy var collectionView: UICollectionView? = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.backgroundColor = .systemGray6
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel?.getDJNews {}
        viewModel?.getJPNews {}
        viewModel?.getTNNews {}
    }
    
    func setViewModel(viewModel: NewsScreenViewModel) {
        self.viewModel = viewModel
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
                print("Tried to layout section 0")
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
            case 1:
                print("Tried to layout section 1")
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

extension NewsListScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramCell.reuseIdentifier, for: indexPath) as? ProgramCell {
                cell.imageView.image = UIImage(systemName: "car.fill")
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticlesContainerCell.reuseIdentifier, for: indexPath) as? ArticlesContainerCell {
                cell.newsLetterNameLabel.text = "Dequeued correctly"
                return cell
            }
        case 2:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsSectionCell.reuseIdentifier, for: indexPath) as? NewsSectionCell {
                cell.newsSectionNameLabel.text = "Section NAME"
                return cell
            }
        case 3:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportsHighlightsCell.reuseIdentifier, for: indexPath) as? SportsHighlightsCell {
                cell.homeTeamImageView.image = UIImage(systemName: "person")
                cell.awayTeamImageView.image = UIImage(systemName: "person.fill")
                cell.awayTeamNameLabel.text = "XDD"
                return cell
            }
        default:
            print("Failed to dequeue cell")
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    
}

