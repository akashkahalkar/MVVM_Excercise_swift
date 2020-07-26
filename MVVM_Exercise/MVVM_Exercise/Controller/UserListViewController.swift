//
//  ViewController.swift
//  MVVM_Exercise
//
//  Created by akash on 22/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let viewModel = UserListViewModel()
    
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
        Log.event("Activity indicator started", .info)
        errorLabel.isHidden = true
        activityIndicator.isHidden = false
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    private func stopLoader() {
        Log.event("Activity indicator stopped", .info)
        errorLabel.isHidden = true
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
    private func showErrorLable(message: String) {
        Log.event("Error label visible", .info)
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
            userDetailsVC.initialize(user: user, index: index)
            DispatchQueue.main.async {
                self.present(userDetailsVC, animated: true, completion: nil)
            }
        }
    }
    
    /// UpdateFavState updates the favorite state for user
    /// on successful updation reloads table view on
    /// main thres
    /// - Parameter id: id of the user for which we have to update the state
    private func updateFavState(for index: Int) {
        if viewModel.updateFavoriteStateForUser(at: index) {
            Log.event("Updated favorite state for user at index: \(index)", .info)
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: index, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
    
    deinit {
        Log.event("User List controller de-initialized", .info)
    }
}

//MARK: - Tableview Delegates

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell") as? UserListCell,
            let rowViewModel = viewModel.getUserRowViewModelList(at: indexPath.row) {
            
            cell.setupUserInfo(index: rowViewModel.getIndex(),
                               name: rowViewModel.getName(),
                               phone: rowViewModel.getUserPhone(),
                               company: rowViewModel.getcompanyName(),
                               website: rowViewModel.getWebsite(),
                               imageName: rowViewModel.getFavImage())
            
            //bind favorite button from cell to the viewmodel to update underlying data
            cell.didTappedFavourite = {[weak self] index in
                self?.updateFavState(for: index)
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

extension UserListViewController: UserStateChangeHandler {
    func userfavoriteStateChanged(index: Int) {
        Log.event("received UserDetailsHandler delegate response", .info)
        updateFavState(for: index)
    }
}
