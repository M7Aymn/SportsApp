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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 16
//        leagueImage.layer.cornerRadius = leagueImage.frame.width/2
        leagueImage.layer.borderWidth = 4.0
        leagueImage.layer.borderColor = UIColor.black.cgColor
        leagueImage.layer.cornerRadius = 10.0
        leagueImage.clipsToBounds = true
//        leagueImage.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

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
