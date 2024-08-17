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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playerImgView.layer.cornerRadius = 16
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.systemBrown.cgColor
        view.layer.borderWidth = 0.3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(player: Player){
        playerImgView.kf.setImage(with: URL(string: player.playerImage ?? ""), placeholder: UIImage(named: "soccerPlayer"))
        playerNameLabel.text = player.playerName
        if player.playerNumber == ""{
            playerNumberLabel.text = "0"
        }else {
            playerNumberLabel.text = player.playerNumber
        }
        
    }

}
