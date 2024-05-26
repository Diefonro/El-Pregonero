//
//  SportsHighlightsCell.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 26/05/2024.
//

import UIKit

class SportsHighlightsCell: UICollectionViewCell, CellInfo {
    
    static var reuseIdentifier = "SportsHighlightsCell"

    @IBOutlet weak var tournamentNameLabel: UILabel!
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var matchStatusLabel: UILabel!
    @IBOutlet weak var collectionContainerView: UIView!
    
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
        collectionView!.register(UINib(nibName: ArticleCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ArticleCell.reuseIdentifier)
    }

    func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int, layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // Item size
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Spacing between items
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            
            // Group size
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            return section
        }
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
    }


}

extension SportsHighlightsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.reuseIdentifier, for: indexPath) as? ArticleCell {
            print("dequeued linearticle successfully")
            cell.newsAuthorImageView.image = UIImage(systemName: "trash")
            cell.newsHeadlineLabel.text = "Sports Headline Label"
            cell.articleImageView.image = UIImage(systemName: "pencil")
            return cell
        } else {
            print("not dequedes asd")
        }
        return UICollectionViewCell()
    }
    
    
}
