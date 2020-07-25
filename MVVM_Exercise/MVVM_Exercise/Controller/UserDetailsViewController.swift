//
//  UserDetailsViewController.swift
//  MVVM_Exercise
//
//  Created by akash on 23/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import UIKit

protocol UserDetailsHandler: class {
    func userfavoriteStateChanged(id: Int)
}

class UserDetailsViewController: UIViewController {
    
    private var viewModel: UserDetailsViewModel?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var companyDescriptionLabel: UILabel!
    
    weak var delegate: UserDetailsHandler?
    
    //MARK: - Initializer
    
    func initialize(user: User) {
        viewModel = UserDetailsViewModel(user: user)
    }
    
    //MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setScreenValues()
    }
    
    //MARK: - Outlets
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        if let vm = viewModel {
            vm.updateFavoriteState()
            setScreenValues()
            delegate?.userfavoriteStateChanged(id: vm.getUserId())
        }
    }
    
    //MARK: - private methods
 
    private func setScreenValues() {
        guard let viewModel = viewModel else {
            return
        }
        nameLabel.text = viewModel.getName()
        userNameLabel.text = viewModel.getUserName()
        addressLabel.text = viewModel.getAddress()
        phoneLabel.text = viewModel.getPhone()
        companyLabel.text = viewModel.getCompanyName()
        companyDescriptionLabel.text = viewModel.getCompanyDescription()
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 40), scale: .medium)
        let image = UIImage(systemName: viewModel.getImageName(), withConfiguration: config)
        favoriteButton.setImage(image, for: .normal)
        //favoriteButton.setBackgroundImage(image, for: .normal)
    }
    
    deinit {
        Log.event("User Details controller de-initialized", .info)

    }
}
