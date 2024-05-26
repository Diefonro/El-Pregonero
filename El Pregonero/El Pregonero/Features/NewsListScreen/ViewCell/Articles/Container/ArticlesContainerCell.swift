//
//  ArticlesContainerCell.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class ArticlesContainerCell: UICollectionViewCell, CellInfo {
    
    static var reuseIdentifier = "ArticlesContainerCell"
    
    @IBOutlet weak var newsLetterImageView: UIImageView!
    @IBOutlet weak var newsLetterNameLabel: UILabel!
    @IBOutlet weak var collectionViewContainer: UIView!
    
    private lazy var collectionView: UICollectionView? = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        return collectionView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        //MARK: Delegates assingment
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
        //MARK: CollectionView size setup.
        collectionViewContainer.addSubview(collectionView!)
        collectionView!.frame = collectionViewContainer.bounds
        collectionView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: collectionViewContainer.topAnchor),
            collectionView!.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor),
            collectionView!.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: collectionViewContainer.bottomAnchor)
        ])
        
        //MARK: Cells registration
        collectionView!.register(UINib(nibName: LineArticleCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: LineArticleCell.reuseIdentifier)
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int, layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // Item size
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Spacing between items
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            // Group size
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
                
                return section
        }
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
    }
}

extension ArticlesContainerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineArticleCell.reuseIdentifier, for: indexPath) as? LineArticleCell {
            cell.newsHeadlineLabel.text = "Dequeued perfectly"
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
