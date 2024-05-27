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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let newsScreen = UIStoryboard(name: UsersListScreenVC.storyboard, bundle: nil)
            .instantiateViewController(withIdentifier: UsersListScreenVC.identifier) as? UsersListScreenVC {
            self.newsCoordinator?.pushToSubcategoryDetail()
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

