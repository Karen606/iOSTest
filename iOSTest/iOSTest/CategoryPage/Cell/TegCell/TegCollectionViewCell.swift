//
//  TegCollectionViewCell.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import UIKit

class TegCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: TegCollectionViewCell.self)
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupContent(category: String) {
        self.categoryNameLabel.text = category
    }

}
