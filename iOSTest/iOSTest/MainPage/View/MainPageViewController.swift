//
//  MainPageViewController.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import UIKit

class MainPageViewController: UIViewController {
    @IBOutlet weak var categoriesTableView: UITableView!
    let mainPageViewModel = MainPageViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
    }
    
    func getCategories() {
        mainPageViewModel.getCategories { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
