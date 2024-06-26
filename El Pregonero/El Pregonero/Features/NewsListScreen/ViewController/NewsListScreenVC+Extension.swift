//
//  NewsListScreenVC+Extension.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 27/05/2024.
//

import UIKit

extension NewsListScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            if DataManager.showsData.isEmpty {
                return 5
            } else {
                return DataManager.showsData.count
            }
        case 1:
            return 3
        case 2:
            return 10
        case 3:
            if DataManager.matchesData.isEmpty {
                return 2
            } else {
                return DataManager.matchesData.count
            }
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let index = indexPath.item
        switch section {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramCell.reuseIdentifier, for: indexPath) as? ProgramCell {
                if let hasData = NewsListScreenVC.showsHasData {
                    if hasData {
                        let data = DataManager.showsData[indexPath.row]
                        cell.setupCell(with: data)
                        cell.updateUIWithData()
                    } else {
                        cell.updateUIWithNoData()
                        cell.isUserInteractionEnabled = false
                    }
                }
                
                return cell
            }
            
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticlesContainerCell.reuseIdentifier, for: indexPath) as? ArticlesContainerCell {
                cell.coordinator = self.newsCoordinator
                cell.lottieView.isHidden = true
                let lottieName = "NewsLottie"
                switch index {
                case 0:
                    cell.setupCell(image: (viewModel?.getJPImageURL())!, name: (viewModel?.getJPName())!, lottieName: lottieName)
                    cell.tapToSearchLabel.isHidden = false
                case 1:
                    cell.setupCell(image: (viewModel?.getTNImageURL())!, name: (viewModel?.getTNName())!, lottieName: lottieName)
                case 2:
                    cell.setupCell(image: (viewModel?.getDJImageURL())!, name: (viewModel?.getDJName())!, lottieName: lottieName)
                default:
                    print("Failed to get newspaper info.")
                }
                cell.section = index
                return cell
            }
        case 2:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsSectionCell.reuseIdentifier, for: indexPath) as? NewsSectionCell {
                let data = viewModel?.newsArray[index]
                cell.setupCellH(image: data?.newsImage, sport: data?.newsTitle)
                return cell
            }
        case 3:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportsHighlightsCell.reuseIdentifier, for: indexPath) as? SportsHighlightsCell {
                if NewsListScreenVC.showsHasData != nil {
                    let data = DataManager.matchesData[indexPath.item]
                    cell.matchData = data
                    cell.setupCell(with: data, lottieName: "NewsSkeleton")
                } else {
                    cell.noInfoView.isHidden = false
                }
                cell.lottieView.isHidden = true
                cell.newsCoordinator = self.newsCoordinator
                cell.cellIndex = indexPath.item
                return cell
            }
        default:
            print("Failed to dequeue cell")
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.section
        let item = indexPath.item
        switch index {
        case 0:
            let data = DataManager.showsData[indexPath.row]
            self.newsCoordinator?.pushToProgramDetail(with: data, navTitle: data.title)
        case 1:
            if indexPath.item == 0 {
                let data = DataManager.newsJPData[indexPath.row]
                self.newsCoordinator?.pushToJPNewsExtended(with: data, with: (viewModel?.getJPName())!, with: item, with: self.newsCoordinator!)
            } else {
                print("hi, tap an item to extend its information :D")
            }
        default:
            print("hi, tap an item to extend its information :D")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = indexPath.section
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? HeaderView {
            switch section {
            case 0:
                headerView.label.text = "Programas"
            case 1:
                headerView.label.text = "Top News"
            case 2:
                headerView.label.text = "Sections"
            case 3:
                headerView.label.text = "Top Matches Results"
            default:
                headerView.label.text = "Test"
            }
            return headerView
        }
        return UICollectionReusableView()
    }
    
}


