//
//  ViewController.swift
//  MVVM_Exercise
//
//  Created by akash on 22/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let viewModel = UserViewModel()
    
    //MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        fetchUserData()
    }
    
    //MARK: - Private method
    
    private func setupTable() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    /// Request user list from network 
    private func fetchUserData() {
        startLoader()
        viewModel.fetchUsers(completion: {[weak self] (error) in
            
            guard let self = self else { return }
            DispatchQueue.main.async {

                if let error = error {
                    self.showErrorLable(message: error.rawValue)
                } else {
                    self.stopLoader()
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    private func startLoader() {
        errorLabel.isHidden = true
        activityIndicator.isHidden = false
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    private func stopLoader() {
        errorLabel.isHidden = true
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
    private func showErrorLable(message: String) {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        tableView.isHidden = true
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
    /// Present user details screen for selected user
    /// - Parameter index: index of the selected user from the list
    private func presentDetailsViewcontroller(index: Int) {
        
        if let user = viewModel.getUser(at: index) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let userDetailsVC = storyboard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
            userDetailsVC.delegate = self
            userDetailsVC.initialize(user: user)
            DispatchQueue.main.async {
                self.present(userDetailsVC, animated: true, completion: nil)
            }
            
        }
        
    }
    
    /// UpdateFavState updates the favorite state for user
    /// on successful updation reloads table view on
    /// main thres
    /// - Parameter id: id of the user for which we have to update the state
    private func updateFavState(for id: Int) {
        if viewModel.updateFavoriteState(id: id) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    deinit {
        debugPrint("User List controller de-initialized")
    }
}

//MARK: - Tableview Delegates

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell") as? UserListCell, let user = viewModel.getUser(at: indexPath.row) {
            
            cell.setupUserInfo(id: user.id, name: user.name,
                               phone: user.phone,
                               company: user.company.name,
                               website: user.website,
                               imageName: user.fav ? "suit.heart.fill" : "suit.heart")
            
            //bind favorite button from cell to the viewmodel to update underlying data
            cell.didTappedFavourite = {[weak self] id in
                self?.updateFavState(for: id)
            }
            return cell
        }
        //fallback if not able to create cell
        let cell = UITableViewCell()
        cell.textLabel?.text = "No data"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentDetailsViewcontroller(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }    
}

//MARK: - UserDetailsHandler delegate comformation

extension UsersViewController: UserDetailsHandler {
    func userfavoriteStateChanged(id: Int) {
        updateFavState(for: id)
    }
}
