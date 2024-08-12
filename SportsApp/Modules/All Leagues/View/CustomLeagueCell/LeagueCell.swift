//
//  LeagueCell.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 12/08/2024.
//

import UIKit

class LeagueCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leagueImage.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setupCell(league: LeagueModel) {
//        leagueName.text = league.leagueName
//        leagueImage.kf.setImage(with: URL(string: league.leagueLogo ?? ""), placeholder: UIImage(systemName: "trophy.circle")?.withTintColor(.brown, renderingMode: .alwaysOriginal))
//    }

}
