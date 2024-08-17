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
        sportImage.layer.cornerRadius = 16
        sportImage.layer.borderWidth = 2.5
        sportImage.layer.borderColor = UIColor.systemBrown.cgColor
    }
    
    func setupSport(title: String, image: UIImage?) {
        sportLabel.text = title
        sportImage.image = image ?? UIImage(systemName: "sportscourt.circle.fill")
    }

}
