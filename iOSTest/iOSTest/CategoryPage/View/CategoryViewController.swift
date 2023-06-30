//
//  CategoryViewController.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var dishesCollectionView: UICollectionView!
    let categoryViewModel = CategoryViewModel()
    var dishes = [Dish]()
//    var tegs: Set<String> = []
    var tegs = [String]()
    enum Section: Int, CaseIterable {
        case categories
        case dishes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        profileImageView.layer.cornerRadius = 100
        profileImageView.image = UIImage(named: "ProfilePhoto")
        let rightButton = UIBarButtonItem(customView: profileImageView)
        self.navigationItem.rightBarButtonItem = rightButton
        getDishes()
        setupCollectionView()
        dishesCollectionView.collectionViewLayout = self.createLayout()
    }
    
    func getDishes() {
        categoryViewModel.getDishes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.dishes = data.dishes
                self.dishes.forEach({ $0.tegs.forEach { teg in
                    if !self.tegs.contains(teg) {
                        self.tegs.append(teg)
                    }
                }})
//                self.dishes.forEach({ $0.tegs.forEach({ self.tegs.insert($0 )})})
                self.dishesCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupCollectionView() {
        dishesCollectionView.delegate = self
        dishesCollectionView.dataSource = self
        dishesCollectionView.register(UINib(nibName: DishCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishCollectionViewCell.identifier)
        dishesCollectionView.register(UINib(nibName: TegCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TegCollectionViewCell.identifier)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNum, environment in
            let determinedSection = Section(rawValue: sectionNum)
            switch determinedSection {
            case .categories:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(80), heightDimension: .estimated(35)))
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(8), top: .none, trailing: .fixed(8), bottom: .none)
                let group: NSCollectionLayoutGroup?
                if self.tegs.isEmpty {
                    group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(0), heightDimension: .estimated(0)), subitems: [item])
                } else {
                    group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(71), heightDimension: .estimated(35)), subitems: [item])
                }
                let section = NSCollectionLayoutSection(group: group!)
                section.contentInsets.bottom = 16
                section.contentInsets.leading = 24
                section.orthogonalScrollingBehavior = .continuous
                return section
            case .dishes:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute((self.dishesCollectionView.frame.width - 48) / 3), heightDimension:.absolute(129))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.edgeSpacing = NSCollectionLayoutEdgeSpacing.init(leading: .fixed(8), top: .fixed(12), trailing: .none, bottom: .none)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(self.dishesCollectionView.frame.width - 48), heightDimension: .estimated(180))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 8
                section.contentInsets.trailing = 24
                section.contentInsets.bottom = 9
                return section
            case .none:
                return NSCollectionLayoutSection(group: .init(layoutSize: .init(widthDimension: .absolute(0), heightDimension: .absolute(0))))
            }
        }
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let determinedSection = Section(rawValue: section)
        switch determinedSection {
        case .categories:
            return tegs.count
        case .dishes:
            return dishes.count
        case .none:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TegCollectionViewCell.identifier, for: indexPath) as! TegCollectionViewCell
            cell.setupContent(category: tegs[indexPath.row])
            return cell
        case .dishes:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCollectionViewCell.identifier, for: indexPath) as! DishCollectionViewCell
            cell.setupContent(dish: dishes[indexPath.row])
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
}
