//
//  SportCell.swift
//  SportsProject
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import UIKit

class SportCell: UICollectionViewCell {

    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var sportImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupSport(name: String, image: UIImage) {
        sportLabel.text = name
        sportImage.image = image
    }

}
