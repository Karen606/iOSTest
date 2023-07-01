//
//  BasketViewViewController.swift
//  iOSTest
//
//  Created by user on 01.07.23.
//

import UIKit

class BasketViewViewController: UIViewController {
    @IBOutlet weak var basketDishesTableView: UITableView!
    @IBOutlet weak var payButton: UIButton!
    private let categoryViewModel = CategoryViewModel()
    private var basketDishes: [Dish] = [] {
        didSet {
            updatePrice()
        }
    }
    private var dishesIds = [Int]()
    private var wholePrice = 0 {
        didSet {
            payButton.setTitle("Оплатить \(wholePrice) ₽", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let ids = UserDefaults.standard.value(forKey: "Basket") as? [Int] {
            dishesIds = ids
        }
        getDishes()
    }
    
    func setupTableView() {
        basketDishesTableView.delegate = self
        basketDishesTableView.dataSource = self
        basketDishesTableView.register(UINib(nibName: BasketDishTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BasketDishTableViewCell.identifier)
    }
    
    func getDishes() {
        categoryViewModel.getDishes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.basketDishes = data.dishes.filter({ self.dishesIds.contains($0.id) })
                let countedSet = NSCountedSet(array: self.dishesIds)
                for index in 0..<self.basketDishes.count {
                    self.basketDishes[index].count = countedSet.count(for: self.basketDishes[index].id)
                }
                self.basketDishesTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updatePrice() {
        var sum = 0
        basketDishes.forEach({ sum += $0.price * ($0.count ?? 0)})
        wholePrice = sum
    }
    
    @IBAction func clickedPay(_ sender: UIButton) {
    }
}

extension BasketViewViewController: UITableViewDelegate {
    
}

extension BasketViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        basketDishes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        78
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = basketDishesTableView.dequeueReusableCell(withIdentifier: BasketDishTableViewCell.identifier, for: indexPath) as! BasketDishTableViewCell
        cell.setupContent(dish: basketDishes[indexPath.section])
        cell.delegate = self
        return cell
    }
}

extension BasketViewViewController: BasketDishTableViewCellDelagate {
    func increment(id: Int, cell: BasketDishTableViewCell) {
        dishesIds.append(id)
        if let index = basketDishes.firstIndex(where: { $0.id == id }) {
            if let count = basketDishes[index].count {
                basketDishes[index].count = count + 1
            }
        }
        updatePrice()
        UserDefaults.standard.set(dishesIds, forKey: "Basket")
    }
    
    func decrement(id: Int, cell: BasketDishTableViewCell) {
        if let index = dishesIds.firstIndex(of: id) {
            dishesIds.remove(at: index)
            if let index = basketDishes.firstIndex(where: { $0.id == id }) {
                if let count = basketDishes[index].count {
                    basketDishes[index].count = count - 1
                }
            }
        }
        updatePrice()
        UserDefaults.standard.set(dishesIds, forKey: "Basket")
    }
    
    func removeDish(id: Int, cell: BasketDishTableViewCell) {
        dishesIds.removeAll(where: { $0 == id })
        UserDefaults.standard.set(dishesIds, forKey: "Basket")
        basketDishes.removeAll(where: { $0.id == id })
        if let indexPath = basketDishesTableView.indexPath(for: cell) {
            basketDishesTableView.deleteSections([indexPath.section], with: .fade)
        }
        updatePrice()
    }
}
