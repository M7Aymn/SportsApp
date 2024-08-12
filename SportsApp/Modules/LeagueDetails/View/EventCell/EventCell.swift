//
//  EventCell.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import UIKit

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
        setupDummyCell()
    }
    
    func setupDummyCell() {
        homeImage.image = UIImage(systemName: "heart")
        homeLabel.text = "Home"
        awayImage.image = UIImage(systemName: "heart")
        awayLabel.text = "Away"
        leagueImage.image = UIImage(systemName: "heart")
        scoreLabel.text = "1 - 2"
        dateLabel.text = "2024-8-12"
        timeLabel.text = "9:00"
    }

}
