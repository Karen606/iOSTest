//
//  CategoriesTableViewCell.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CategoriesTableViewCell.self)
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16))
    }
    
    func setupContent(category: KitchenCategory) {
        categoryName.text = category.name
        categoryName.sizeToFit()
        categoryImageView.load(str: category.imageURL)
    }
    
}
