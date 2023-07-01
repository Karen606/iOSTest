//
//  BasketDishTableViewCell.swift
//  iOSTest
//
//  Created by user on 01.07.23.
//

import UIKit

protocol BasketDishTableViewCellDelagate: AnyObject {
    func increment(id: Int, cell: BasketDishTableViewCell)
    func decrement(id: Int, cell: BasketDishTableViewCell)
    func removeDish(id: Int, cell: BasketDishTableViewCell)
}

class BasketDishTableViewCell: UITableViewCell {
    static let identifier = String(describing: BasketDishTableViewCell.self)
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var dishWeightLabel: UILabel!
    @IBOutlet weak var dishCountLabel: UILabel!
    weak var delegate: BasketDishTableViewCellDelagate?
    var id: Int?
    var count: Int = 1 {
        didSet {
            dishCountLabel.text = String(count)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
    }
    
    func setupContent(dish: Dish) {
        dishImageView.load(str: dish.imageURL)
        dishNameLabel.text = dish.name
        dishPriceLabel.text = "\(dish.price) ₽"
        dishWeightLabel.text = ". \(dish.weight)г"
        id = dish.id
        count = dish.count ?? 1
    }
    
    @IBAction func clickedMinus(_ sender: UIButton) {
        guard let id = id else { return }
        count -= 1
        count > 0 ? delegate?.decrement(id: id, cell: self) : delegate?.removeDish(id: id, cell: self)
    }
    
    @IBAction func clickedPlus(_ sender: UIButton) {
        if let id = id {
            count += 1
            delegate?.increment(id: id, cell: self)
        }
    }
}
