//
//  LeagueCell.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 12/08/2024.
//

import UIKit
import Kingfisher

class LeagueCell: UITableViewCell {
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var button: UIButton!
    var buttonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leagueImage.layer.cornerRadius = 16
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(league: LeagueModel) {
        leagueName.text = league.leagueName
        leagueImage.kf.setImage(with: URL(string: league.leagueLogo ?? ""), placeholder: UIImage(named: "leagueLogo"))
    }
    #warning("check if button and webview need refactor")
    @IBAction func youtubeButtonPressed(_ sender: UIButton) {
        buttonTapped!()
    }
    
}
