//
//  UserListCell.swift
//  MVVM_Exercise
//
//  Created by akash on 23/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var didTappedFavourite: ((Int)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    @IBAction func isFavoriteButtonTap(_ sender: Any) {
        didTappedFavourite?(tag)
    }
    
    func setupUserInfo(index: Int, name: String, phone: String, company: String, website: String, imageName: String) {
        self.tag = index
        nameLabel.text = name
        phoneLabel.text = phone
        companyLabel.text = company
        websiteLabel.text = website
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 30), scale: .medium)
        let favImage = UIImage(systemName: imageName, withConfiguration: config)
        DispatchQueue.main.async {
            self.favButton.setImage(favImage, for: .normal)
        }
    }
}
