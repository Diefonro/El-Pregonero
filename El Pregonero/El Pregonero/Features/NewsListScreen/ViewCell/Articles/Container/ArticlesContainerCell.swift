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
    
    var cellIndex = 0
    var section: Int = 0 {
        didSet {
            cellIndex = section
        }
    }
    
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
    
    func setupCell(image: String, name: String) {
        self.newsLetterNameLabel.text = name
        if let imageUrl = URL(string: image) {
            self.newsLetterImageView.setImage(from: imageUrl)
        } else {
            self.newsLetterImageView.image = UIImage(systemName: "newspaper")
        }
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
        let JPData = DataManager.newsJPData
        let TNData = DataManager.newsTNData
        let DJData = DataManager.newsDJData
        
        switch cellIndex {
        case 0:
            return JPData.count - 90
        case 1:
            return TNData.count
        case 2:
            return DJData.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineArticleCell.reuseIdentifier, for: indexPath) as? LineArticleCell {
            let index = indexPath.row
            let JPData = DataManager.newsJPData[index]
//            let TNData = DataManager.newsTNData[index]
//            let DJData = DataManager.newsDJData[index]

            switch cellIndex {
            case 0:
                cell.newsHeadlineLabel.text = JPData.title
                cell.articleImageView.setImage(from: URL(string: JPData.image)!)
                cell.newsAuthorImageView.setImage(from: URL(string: JPData.thumbnail)!)
                cell.newsAuthorNameLabel.text = JPData.slug
            case 1:
                break
            case 2:
                break
            default:
                break
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
