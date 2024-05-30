//
//  MatchDetailScreenVC.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import UIKit

class MatchDetailScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "MatchDetailScreen"
    static var identifier = "MatchDetailScreenVC"
    
    var matchData: MatchElement?
    var data: News?
    var navTitle = ""

    @IBOutlet weak var tournamentNameLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var matchStatusLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsPublishedDateLabel: UILabel!
    @IBOutlet weak var newsGoToSiteButton: UIButton!
    @IBOutlet weak var matchResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = matchData {
            setupMatchView(with: data)
        }
        
        if let data = data {
            setupView(with: data)
        }
    }
    
    func setupMatchView(with data: MatchElement) {
        let status = data.status.capitalizeFirstCharacter()
        self.tournamentNameLabel.text = data.competition
        self.homeTeamScoreLabel.text = String(data.score.home)
        self.awayTeamScoreLabel.text = String(data.score.away)
        self.homeTeamNameLabel.text = data.homeTeam.nameShort
        self.awayTeamNameLabel.text = data.awayTeam.nameShort
        self.matchStatusLabel.text = status
        self.homeTeamImageView.setImage(from: URL(string: data.homeTeam.crest)!)
        self.awayTeamImageView.setImage(from: URL(string: data.awayTeam.crest)!)
        
        updateMatchResultLabels(with: data)
        updateMatchStatusLabels(with: status)
    }

    private func updateMatchResultLabels(with data: MatchElement) {
        let matchResult = data.score.winner
        let winningColor = UIColor().colorFromHex("#008f00")
        
        switch matchResult {
        case data.homeTeam.name:
            setWinningTeamLabels(winningColor, team: .home, matchResult: matchResult)
        case data.awayTeam.name:
            setWinningTeamLabels(winningColor, team: .away, matchResult: matchResult)
        case "draw":
            self.matchResultLabel.text = "DRAW!"
            self.matchResultLabel.textColor = UIColor().colorFromHex("#00538f")
        default:
            break
        }
    }

    private enum Team {
        case home, away
    }

    private func setWinningTeamLabels(_ color: UIColor, team: Team, matchResult: String) {
        switch team {
        case .home:
            self.homeTeamScoreLabel.textColor = color
            self.homeTeamNameLabel.textColor = color
        case .away:
            self.awayTeamScoreLabel.textColor = color
            self.awayTeamNameLabel.textColor = color
        }
        self.matchResultLabel.text = "WINNER!: \(matchResult)"
        self.matchResultLabel.textColor = color
    }

    private func updateMatchStatusLabels(with status: String) {
        switch status {
        case "L":
            self.matchResultLabel.text = "MATCH IS LIVE!"
            self.matchResultLabel.textColor = .black
            self.matchStatusLabel.textColor = .green
        case "U":
            self.matchResultLabel.text = "MATCH WILL START SOON!"
            self.matchResultLabel.textColor = .black
            self.matchStatusLabel.textColor = UIColor().colorFromHex("#00538f")
        default:
            break
        }
    }

    
    func setupView(with data: News) {
        newsImageView.setImage(from: URL(string: data.urlImage)!)
        newsTitleLabel.text = data.title
        newsAuthorLabel.text = "Written by: \(data.author)"
        newsDescriptionLabel.text = data.description
        newsGoToSiteButton.setTitle("Go to site!", for: .normal)
        newsGoToSiteButton.accessibilityHint = data.source
        
        if let date = data.publishedAt.toDate() {
            newsPublishedDateLabel.text = "Published at \(date.formattedPublishedDate())."
        }
    }
    
    @IBAction func newsGoToSiteButtonAction(_ sender: UIButton) {
        if let link = sender.accessibilityHint, let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
}
