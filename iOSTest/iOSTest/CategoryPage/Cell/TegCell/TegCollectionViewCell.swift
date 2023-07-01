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
    
    var tegIsSelected: Bool? {
        didSet {
            guard let tegIsSelected = tegIsSelected else { return }
            self.backgroundColor = tegIsSelected ? #colorLiteral(red: 0.2, green: 0.3921568627, blue: 0.8784313725, alpha: 1) : #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9607843137, alpha: 1)
            self.categoryNameLabel.textColor = tegIsSelected ? .white : .black
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupContent(category: String) {
        self.categoryNameLabel.text = category
    }

}
