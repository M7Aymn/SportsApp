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
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var button: UIButton!
    var buttonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCellUI() {
        leagueImage.layer.cornerRadius = 16
//        contentView.backgroundColor = UIColor.secondarySystemFill
//        contentView.layer.borderColor = UIColor.systemBrown.cgColor
//        contentView.layer.borderWidth = 1.0
//        contentView.layer.masksToBounds = true
        
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor.systemBrown.cgColor
        view.layer.borderWidth = 1.0
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
