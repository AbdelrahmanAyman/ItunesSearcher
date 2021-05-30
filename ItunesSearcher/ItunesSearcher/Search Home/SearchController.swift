//
//  SearchController.swift
//  ItunesSearcher
//
//  Created by AH MARWAN  on 29/05/21.
//

import UIKit

class SearchController: UIViewController, UITextFieldDelegate {

    // MARK:- Outlets
    // TableView
    @IBOutlet weak var tableView: UITableView!
    // Search View
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchField: UITextField!
    
    
    // MARK: - Properties / Models
    let networkHandler = NetworkHandler()
    var results: [Result] = []
   
    
    // refresh
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        getArtists()
        refreshTableView()
    }

}



//MARK:- extension UITableViewDelegate && UITableViewDataSource
extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        cell.setUpCell(result: results[indexPath.row])
        return cell
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        
        // Show Popup ArtistDetailController
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "artistDetailController") as! ArtistDetailController
        popOverVC.entity = results[indexPath.row]
        self.present(popOverVC, animated: true)
    }
    
    
}


// MARK: - Func Helper
extension SearchController {
    
    // Reload the tableView
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.updateEmptyState(rowsCount: self.results.count, emptyMessage: "No data found!")
            self.tableView.reloadData()
        }
    }
    
    
    // refresh
    func refreshTableView(){
        refreshControl.attributedTitle = NSAttributedString(string: "Reload",
        attributes: [NSAttributedString.Key.foregroundColor: Config.orange!])
        refreshControl.tintColor = Config.orange
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    // Poll to refresh
    @objc func refresh(_ sender: AnyObject) {
        // Get new data
        self.getArtists()
        // End Refreshing
        refreshControl.endRefreshing()
    }
    
    
    func getArtists(){
        DispatchQueue.main.async {
            if Connectivity.isConnectedToInternet() {
                self.callAPI()
            }else{
                self.alert(title: "", message: "Not connected to the internet. Please check your internet connection.", preferredStyle: .alert) {_ in
                    self.reloadTableView()
                }
            }
        }
    }
    
    func callAPI(){
        
        DispatchQueue.main.async {
            // Strat animation
            self.view.startLoading()
        }
        

        
        // set defult search value to Michael Jackson 
        var textInput = ""
        if searchField.text == "" {
            textInput = "Michael Jackson"
        }else{
            textInput = searchField.text!
        }
        
        // call API
        let params = textInput.replacingOccurrences(of: " ", with: "+", range: nil)
        networkHandler.postData(urlPath: "search?term=\(params)", method: .get, with: ItunesModel.self, parameters: .none) { [weak self](response) in
            
            DispatchQueue.main.async {
                // Stop animation
                self?.view.stopLoading()
            }
            
            guard let self = self , let data = response else {return}
            
            // Remove all data
            self.results.removeAll()
            // Append new data
            self.results.append(contentsOf: data.results ?? [])
            // Reload View
            self.reloadTableView()
            
        } returnError: { error in
            self.view.stopLoading()
            // Show error message
            self.alert(title: "Error", message: error?.localizedDescription ?? "Ops, something went wrong try again later.", preferredStyle: .alert, completion: { _ in})
        }
        
    }
    
    
}




//MARK:- Search
extension SearchController {
    
    // Reload tableView when cancell all text
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchField.text = ""
        getArtists()
        return false
    }
    
    // Reload tableView when click "Search" on Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchField.returnKeyType = .search
        getArtists()
        return true
    }
}



// MARK:- Func SetUpView
extension SearchController {
    
    func setUpView(){
        
        // Set backgroundColor View
        view.backgroundColor = Config.darkBlue
        
        // Set TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        // Set Search View
        searchView.backgroundColor = Config.darkGray
        searchView.layer.cornerRadius = Config.cornerRadius
        //searchView.dropShadow()
        
        // Set Search image
        searchImg.image = UIImage(named: "search")
        searchImg.contentMode = .scaleAspectFill
        
        // Set Search Field
        searchField.delegate = self
        searchField.textColor = Config.gray
        searchField.font = medium(Config.body)
        searchField.attributedPlaceholder = NSAttributedString(string: "Search",
        attributes: [NSAttributedString.Key.foregroundColor: Config.gray ?? .gray ])
        
    }
    
}
