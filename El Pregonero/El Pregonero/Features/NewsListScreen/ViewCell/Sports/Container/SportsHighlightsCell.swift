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
    @IBOutlet weak var lottieView: NLottieAnimation!
    @IBOutlet weak var noInfoView: NoInfoView!
    
    var newsCoordinator: NewsScreenCoordinator?
    var navTitle = ""
    var lottieName = ""
    var matchData: MatchElement?
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
        lottieView.changeLottie(lottieName: "NewsLottie")
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateData), name: .didUpdateMatchesData, object: nil)
    }
    
    func setupCell(with data: MatchElement, lottieName: String) {
        self.lottieName = lottieName
        let status = data.status.capitalizeFirstCharacter()
        self.tournamentNameLabel.text = data.competition
        self.homeTeamScoreLabel.text = String(data.score.home)
        self.awayTeamScoreLabel.text = String(data.score.away)
        self.homeTeamNameLabel.text = data.homeTeam.nameShort
        self.awayTeamNameLabel.text = data.awayTeam.nameShort
        self.matchStatusLabel.text = status
        self.homeTeamImageView.setImage(from: URL(string: data.homeTeam.crest)!)
        self.awayTeamImageView.setImage(from: URL(string: data.awayTeam.crest)!)
        
        if status == "L" {
            self.matchStatusLabel.textColor = UIColor().colorFromHex("#008f00")
            
        } else if status == "U" {
            self.matchStatusLabel.textColor = UIColor().colorFromHex("#00538f")
        }
    }
    
    @objc func didUpdateData() {
        DispatchQueue.main.async {
            self.collectionView!.reloadData()
        }
    }
    
    func setupCollectionView() {
        
        //MARK: Delegates assingment
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.prefetchDataSource = self
        collectionView!.isPrefetchingEnabled = true
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension SportsHighlightsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            switch cellIndex {
            case 0:
                guard indexPath.row < DataManager.matchesData.count else { continue }
                let _ = DataManager.matchesData[indexPath.row]
            default:
                continue
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.reuseIdentifier, for: indexPath) as? ArticleCell {
            let data: News
            
            switch cellIndex {
            case 0:
                data = DataManager.matchesNewsOne[indexPath.row]
            case 1:
                data = DataManager.matchesNewsTwo[indexPath.row]
            case 2:
                data = DataManager.matchesNewsThree[indexPath.row]
            case 3:
                data = DataManager.matchesNewsFour[indexPath.row]
            default:
                data = DataManager.matchesNewsOne[indexPath.row]
            }
            
            cell.setupCell(with: data)
            return cell
        } else {
            print("not dequedes asd")
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data: News
        
        switch cellIndex {
        case 0:
            data = DataManager.matchesNewsOne[indexPath.row]
            self.newsCoordinator?.pushToMatchDetail(with: data, with: self.matchData!, navTitle: data.title)
        case 1:
            data = DataManager.matchesNewsTwo[indexPath.row]
            self.newsCoordinator?.pushToMatchDetail(with: data, with: self.matchData!, navTitle: data.title)
        case 2:
            data = DataManager.matchesNewsThree[indexPath.row]
            self.newsCoordinator?.pushToMatchDetail(with: data, with: self.matchData!, navTitle: data.title)
        case 3:
            data = DataManager.matchesNewsFour[indexPath.row]
            self.newsCoordinator?.pushToMatchDetail(with: data, with: self.matchData!, navTitle: data.title)
        default:
            print("Couldn't navigate to match detail :(")
        }
    }
    
}
