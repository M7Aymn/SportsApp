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
    }
    
    func setupCell(event: EventModel) {
        homeImage.kf.setImage(with: URL(string: event.homeTeamLogo))
        homeLabel.text = event.eventHomeTeam
        awayImage.kf.setImage(with: URL(string: event.awayTeamLogo))
        awayLabel.text = event.eventAwayTeam
        leagueImage.kf.setImage(with: URL(string: event.leagueLogo))
        scoreLabel.text = event.eventFinalResult
        dateLabel.text = event.eventDate
        timeLabel.text = event.eventTime
        
        if event.eventFinalResult == "-" {
            scoreLabel.text = " "
        }
    }

}
