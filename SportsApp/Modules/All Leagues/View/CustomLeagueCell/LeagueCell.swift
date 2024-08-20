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
    @IBOutlet weak var leagueImageBackView: UIView!
    
    var buttonTapped: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCellUI() {
        leagueImageBackView.layer.cornerRadius = leagueImageBackView.frame.width / 2
        leagueImageBackView.clipsToBounds = true
        leagueImageBackView.layer.borderColor = UIColor.systemBrown.cgColor
        leagueImageBackView.layer.borderWidth = 1.0

        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor.systemBrown.cgColor
        view.layer.borderWidth = 1.0
    }
    
    func setupCell(league: LeagueModel) {
        leagueName.text = league.leagueName
        leagueImage.kf.setImage(with: URL(string: league.leagueLogo ?? ""), placeholder: UIImage(named: "leagueLogo"))
    }
    
    @IBAction func youtubeButtonPressed(_ sender: UIButton) {
        buttonTapped?()
    }
    
}
