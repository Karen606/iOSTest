//
//  MainPageViewController.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import UIKit

class MainPageViewController: UIViewController {
    @IBOutlet weak var categoriesTableView: UITableView!
    var categories = [KitchenCategory]()
    let mainPageViewModel = MainPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getCategories()
    }
    
    func setupTableView() {
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.register(UINib(nibName: CategoriesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoriesTableViewCell.identifier)
    }
    
    func getCategories() {
        mainPageViewModel.getCategories { result in
            switch result {
            case .success(let data):
                self.categories = data.сategories
                self.categoriesTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MainPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        148
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as! CategoriesTableViewCell
        cell.setupContent(category: categories[indexPath.section])
        return cell
    }
}

extension MainPageViewController: UITableViewDelegate {
    
}
