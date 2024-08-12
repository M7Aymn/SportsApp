//
//  TeamCell.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import UIKit

class TeamCell: UICollectionViewCell {
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 16
        teamImage.layer.cornerRadius = teamImage.frame.width / 2
        setupCell()
    }
    
    func setupCell() {
        teamLabel.text = "Team Name"
        teamImage.image = UIImage(systemName: "heart")
    }
    
}



