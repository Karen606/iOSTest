//
//  CategoriesTableViewCell.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CategoriesTableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16))
    }
    
}
