//
//  EventCell.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import UIKit
import Kingfisher

class EventCell: UICollectionViewCell {
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayImage: UIImageView!
    @IBOutlet weak var awayLabel: UILabel!
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var leagueBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 16
//        leagueImage.layer.cornerRadius = leagueImage.frame.width/2
//        leagueBackgroundView.layer.borderWidth = 2.0
//        leagueBackgroundView.layer.borderColor = UIColor.green.cgColor
//        leagueBackgroundView.layer.cornerRadius = 8
//        leagueImage.layer.cornerRadius = 8
//        leagueImage.clipsToBounds = true
//        leagueBackgroundView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).translatedBy(x: 0, y: -25)
//        leagueImage.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//        leagueBackgroundView.alpha = 0.66
        leagueBackgroundView.isHidden = true

    }
    
    func setupCell(event: EventModel) {
        homeImage.kf.setImage(with: URL(string: event.homeTeamLogo ?? ""), placeholder: UIImage(named: "teamLogo"))
        homeLabel.text = event.eventHomeTeam
        awayImage.kf.setImage(with: URL(string: event.awayTeamLogo ?? ""), placeholder: UIImage(named: "teamLogo"))
        awayLabel.text = event.eventAwayTeam
        leagueImage.kf.setImage(with: URL(string: event.leagueLogo ?? ""), placeholder: UIImage(named: "leagueLogo"))
        scoreLabel.text = event.eventFinalResult
        dateLabel.text = event.eventDate
        timeLabel.text = event.eventTime
        
        if event.eventFinalResult == "-" {
            scoreLabel.text = " "
        }
    }

}
