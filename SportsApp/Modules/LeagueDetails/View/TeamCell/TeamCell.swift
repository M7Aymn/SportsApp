//
//  TeamCell.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import UIKit
import Kingfisher

class TeamCell: UICollectionViewCell {
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 16
        teamImage.layer.cornerRadius = teamImage.frame.width / 2
    }
    
    func setupCell(team: Team) {
        teamLabel.text = team.teamName
        teamImage.kf.setImage(with: URL(string: team.teamLogo))
    }
    
}



