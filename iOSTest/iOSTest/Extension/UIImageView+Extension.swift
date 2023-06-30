//
//  UIImage+Extension.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import Foundation
import ImageLoader

extension UIImageView {
    func load(str: String) {
        let url = URL(string: str)
        if let url = url {
            self.load.request(with: url)
        } else {
            return
        }
    }
}
