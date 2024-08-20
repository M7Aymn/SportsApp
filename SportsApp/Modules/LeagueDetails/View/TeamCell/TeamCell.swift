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
    @IBOutlet weak var teamImageBackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }
    
    private func setupCellUI() {
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.systemBrown.cgColor
        
        DispatchQueue.main.async {
            self.teamImageBackView.layer.cornerRadius = self.teamImageBackView.frame.height / 2
        }
        teamImageBackView.clipsToBounds = true
        teamImageBackView.layer.borderColor = UIColor.systemBrown.cgColor
        teamImageBackView.layer.borderWidth = 1.0
    }
    
    func setupCell(team: TeamModel) {
        teamLabel.text = team.teamName
        teamImage.kf.setImage(with: URL(string: team.teamLogo ?? ""), placeholder: UIImage(named: "teamLogo"))
    }
    
}



