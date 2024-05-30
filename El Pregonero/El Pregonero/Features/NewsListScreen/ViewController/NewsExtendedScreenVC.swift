//
//  NewsExtendedScreenVC.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import UIKit

class NewsExtendedScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "NewsExtendedScreen"
    static var identifier = "NewsExtendedScreenVC"
    
    var coordinator: NewsScreenCoordinator?
    var filteredNews: JPNews = []
    
    var navTitle = ""
    var cellIndex = 0
    var section: Int = 0 {
        didSet {
            cellIndex = section
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewContainer: UIView!
    
    private lazy var collectionView: UICollectionView? = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomMainSearchBar.customizeSearchBar(with: self.searchBar)
        setupCollectionView()
        filterContentForSearchText("")
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = navTitle
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
    
    private func filterContentForSearchText(_ searchText: String) {
            if searchText.isEmpty {
                filteredNews = DataManager.newsJPData
            } else {
                filteredNews = DataManager.newsJPData.filter { news in
                    return news.title.localizedCaseInsensitiveContains(searchText) || news.content.localizedCaseInsensitiveContains(searchText)
                }
            }
            
            collectionView!.reloadData()
            
            if filteredNews.isEmpty {
                //TODO: Pending to add NoInFoView
            }
        }
    
    
}

extension NewsExtendedScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard indexPath.row < DataManager.newsJPData.count else { continue }
            let _ = DataManager.newsJPData[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineArticleCell.reuseIdentifier, for: indexPath) as? LineArticleCell else {
            fatalError("Failed to dequeue LineArticleCell")
        }
        
        let JPData = filteredNews[indexPath.item]
        cell.setupJPCell(with: JPData)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let JPData = filteredNews[indexPath.item]
           self.coordinator?.pushToJPNewsDetail(with: JPData, navTitle: JPData.title)
    }
}

extension NewsExtendedScreenVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           filterContentForSearchText(searchText)
       }
       
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder()
       }
}
