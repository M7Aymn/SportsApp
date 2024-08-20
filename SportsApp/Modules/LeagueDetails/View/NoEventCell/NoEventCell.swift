//
//  NoEventCell.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 18/08/2024.
//

import UIKit

class NoEventCell: UICollectionViewCell {
    
    @IBOutlet weak var noEventImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.layer.cornerRadius = 16
        noEventImage.layer.cornerRadius = 16
    }
    
}
