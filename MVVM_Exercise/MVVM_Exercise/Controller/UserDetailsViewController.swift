//
//  UserDetailsViewController.swift
//  MVVM_Exercise
//
//  Created by akash on 23/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    private var viewModel: UserDetailsViewModel?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var companyDescriptionLabel: UILabel!
    
    weak var delegate: UserStateChangeHandler?
    
    //MARK: - Initializer
    
    func initialize(user: User, index: Int) {
        viewModel = UserDetailsViewModel(user: user, index: index)
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
            delegate?.userfavoriteStateChanged(index: vm.getIndex())
        }
    }
    
    //MARK: - private methods
 
    private func setScreenValues() {
        guard let viewModel = viewModel else {
            return
        }
        DispatchQueue.main.async {
            self.nameLabel.text = viewModel.getName()
            self.userNameLabel.text = viewModel.getUserName()
            self.addressLabel.text = viewModel.getAddress()
            self.phoneLabel.text = viewModel.getPhone()
            self.companyLabel.text = viewModel.getCompanyName()
            self.companyDescriptionLabel.text = viewModel.getCompanyDescription()
            let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 40), scale: .medium)
            let image = UIImage(systemName: viewModel.getImageName(), withConfiguration: config)
            self.favoriteButton.setImage(image, for: .normal)
        }
    }
    
    deinit {
        Log.event("User Details controller de-initialized", .info)
    }
}
