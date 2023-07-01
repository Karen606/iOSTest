//
//  DishViewController.swift
//  iOSTest
//
//  Created by user on 01.07.23.
//

import UIKit

class DishViewController: UIViewController {
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var dishWeightLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    var dish: Dish?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        setContent()
    }
    
    func setContent() {
        if let dish = dish {
            dishImageView.load(str: dish.imageURL)
            dishNameLabel.text = dish.name
            dishPriceLabel.text = "\(dish.price) ₽"
            dishWeightLabel.text = ". \(dish.weight)г"
            dishDescriptionLabel.text = dish.description
        }
    }

    @IBAction func clickedClose(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func clickedAddToBasket(_ sender: UIButton) {
        guard let dish = dish else { return }
        if var basket = UserDefaults.standard.array(forKey: "Basket") as? [Int] {
            basket.append(dish.id)
            UserDefaults.standard.set(basket, forKey: "Basket")
        } else {
            UserDefaults.standard.set([dish.id], forKey: "Basket")
        }
    }
    
}
