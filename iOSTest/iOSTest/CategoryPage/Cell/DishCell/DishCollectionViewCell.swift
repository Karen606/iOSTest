//
//  DishCollectionViewCell.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import UIKit

class DishCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: DishCollectionViewCell.self)
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupContent(dish: Dish) {
        dishImageView.load(str: dish.imageURL)
        dishNameLabel.text = dish.name
        dishNameLabel.sizeToFit()
    }

}
