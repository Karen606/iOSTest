//
//  TabBarViewController.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    lazy var personalInformationStackView
    : UIBarButtonItem = {
        let cityLabel = UILabel()
        cityLabel.textAlignment = .left
        cityLabel.text = "Москва"
        cityLabel.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        cityLabel.textColor = .black
        let dobLabel = UILabel()
        dobLabel.textAlignment = .left
        dobLabel.text = "26 Апреля, 1998"
        dobLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        dobLabel.textColor = .black.withAlphaComponent(0.5)
        let stackView = UIStackView(arrangedSubviews: [cityLabel, dobLabel])
        stackView.axis = .vertical
        let personalInformation = UIBarButtonItem(customView: stackView)
        return personalInformation
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        profileImageView.layer.cornerRadius = 100
        profileImageView.image = UIImage(named: "ProfilePhoto")
        let rightButton = UIBarButtonItem(customView: profileImageView)
        self.navigationItem.rightBarButtonItem = rightButton
        let locationImageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        locationImageview.image = UIImage(named: "LocationIcon")
        let leftImageView = UIBarButtonItem(customView: locationImageview)
        self.navigationItem.leftBarButtonItems = [leftImageView, personalInformationStackView]
    }
}
