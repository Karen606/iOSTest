//
//  BasketDishTableViewCell.swift
//  iOSTest
//
//  Created by user on 01.07.23.
//

import UIKit

class BasketDishTableViewCell: UITableViewCell {
    static let identifier = String(describing: BasketDishTableViewCell.self)
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var dishWeightLabel: UILabel!
    @IBOutlet weak var dishCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupContent(dish: Dish) {
        dishImageView.load(str: dish.imageURL)
        dishNameLabel.text = dish.name
        dishPriceLabel.text = "\(dish.price)"
        dishWeightLabel.text = "\(dish.weight)"
    }
    
    @IBAction func clickedMinus(_ sender: UIButton) {
    }
    
    @IBAction func clickedPlus(_ sender: UIButton) {
    }
    
}
