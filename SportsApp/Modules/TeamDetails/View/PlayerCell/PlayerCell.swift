//
//  PlayerCell.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 17/08/2024.
//

import UIKit
import Kingfisher

class PlayerCell: UITableViewCell {
    @IBOutlet weak var playerImgView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var playerImgBackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCellUI() {
        playerImgBackView.layer.cornerRadius = playerImgBackView.frame.height / 2
        playerImgBackView.clipsToBounds = true
        playerImgBackView.layer.borderColor = UIColor.systemBrown.cgColor
        playerImgBackView.layer.borderWidth = 0.5

        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor.systemBrown.cgColor
        view.layer.borderWidth = 0.5
    }
    
    func setupCell(player: Player) {
        playerImgView.kf.setImage(with: URL(string: player.playerImage ?? ""), placeholder: UIImage(named: "soccerPlayer"))
        playerNameLabel.text = player.playerName
        if player.playerNumber == "" {
            playerNumberLabel.text = "0"
        } else {
            playerNumberLabel.text = player.playerNumber
        }
    }
    
}
