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
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateJPNewsData), name: .didUpdateDJNewsData, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(didUpdateJPNewsData), name: .didUpdateJPNewsData, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(didUpdateJPNewsData), name: .didUpdateTNNewsData, object: nil)
    }
    
    @objc func didUpdateJPNewsData() {
        DispatchQueue.main.async {
            self.collectionView!.reloadData()
        }
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
        collectionView!.prefetchDataSource = self
        collectionView!.isPrefetchingEnabled = true
        
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

extension ArticlesContainerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            switch cellIndex {
            case 0:
                guard indexPath.row < DataManager.newsJPData.count else { continue }
                let _ = DataManager.newsJPData[indexPath.row]
            case 1:
                guard indexPath.row < DataManager.newsTNData.count else { continue }
                let _ = DataManager.newsTNData[indexPath.row]
            case 2:
                guard indexPath.row < DataManager.newsDJData.count else { continue }
                let _ = DataManager.newsDJData[indexPath.row]
            default:
                continue
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellIndex {
        case 0:
            return DataManager.newsJPData.count - 90
        case 1:
            return DataManager.newsTNData.count
        case 2:
            return DataManager.newsDJData.count - 20
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineArticleCell.reuseIdentifier, for: indexPath) as? LineArticleCell {
            switch cellIndex {
            case 0:
                let index = indexPath.row
                let JPData = DataManager.newsJPData[index]
                cell.setupJPCell(with: JPData)
            case 1:
                let index = indexPath.row
                let TNData = DataManager.newsTNData[index]
                cell.setupTNCell(with: TNData)
            case 2:
                let index = indexPath.row
                let DJData = DataManager.newsDJData[index]
                cell.setupDJCell(with: DJData)
            default:
                break
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
