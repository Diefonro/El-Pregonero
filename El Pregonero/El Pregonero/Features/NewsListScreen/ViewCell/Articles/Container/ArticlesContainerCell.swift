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
    @IBOutlet weak var tapToSearchLabel: UILabel!
    @IBOutlet weak var collectionViewContainer: UIView!
    @IBOutlet weak var lottieView: NLottieAnimation!
    @IBOutlet weak var noInfoInside: NoInfoView!
    
    var cellIndex = 0
    var section: Int = 0 {
        didSet {
            cellIndex = section
        }
    }
    var navTitle = ""
    var lottieName = ""
    var coordinator: NewsScreenCoordinator?
    
    private lazy var collectionView: UICollectionView? = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        return collectionView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        lottieView.changeLottie(lottieName: "NewsLottie")
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateData), name: .didUpdateDJNewsData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateData), name: .didUpdateJPNewsData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateData), name: .didUpdateTNNewsData, object: nil)
    }
    
    @objc func didUpdateData() {
        DispatchQueue.main.async {
            self.collectionView!.reloadData()
        }
    }
    
    func setupCell(image: String, name: String, lottieName: String) {
        self.newsLetterNameLabel.text = name
        self.lottieName = lottieName
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
            return DataManager.newsJPData.count - 88
        case 1:
            return DataManager.newsTNData.count
        case 2:
            return DataManager.newsDJData.count - 18
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineArticleCell.reuseIdentifier, for: indexPath) as? LineArticleCell {
            switch cellIndex {
            case 0:
                let index = indexPath.row
                let JPData = DataManager.newsJPData
                if !JPData.isEmpty {
                    cell.setupJPCell(with: JPData[index])

                } else {
                    self.noInfoInside.isHidden = false
                }
            case 1:
                let index = indexPath.row
                let TNData = DataManager.newsTNData
                if !TNData.isEmpty {
                    cell.setupTNCell(with: TNData[index])
                } else {
                    self.noInfoInside.isHidden = false
                }
               
            case 2:
                let index = indexPath.row
                let DJData = DataManager.newsDJData
                if !DJData.isEmpty {
                    cell.setupDJCell(with: DJData[index])
                } else {
                    self.noInfoInside.isHidden = false
                }
                
                default:
                print("default in line article dequeue")
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch cellIndex {
        case 0:
            let JPData = DataManager.newsJPData[indexPath.row]
            self.coordinator?.pushToJPNewsDetail(with: JPData, navTitle: JPData.title)
        case 1:
            let TNData = DataManager.newsTNData[indexPath.row]
            self.coordinator?.pushToTNNewsDetail(with: TNData, navTitle: TNData.title)
        case 2:
            let DJData = DataManager.newsDJData[indexPath.row]
            self.coordinator?.pushToDJNewsDetail(with: DJData, navTitle: DJData.title)
        default:
            break
        }
    }
}
