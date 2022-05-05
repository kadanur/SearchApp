//
//  ViewController.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 29.04.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    var accounts1 = [Account]() // İlk Veri
    var accounts2 = [Account]() // İkinci Veri
    var selectedAccounts = [Account]() // Seçilen Veri
    var filteredAccounts = [Account]() // Filtrelenen Veri
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VC loaded")
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Ara..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        loadData()
    }
    
    @IBAction func segmentedControlFunc(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
            {
            case 0:
            selectedAccounts = accounts1
            filteredAccounts = selectedAccounts
            searchController.isActive = false
            tableView.reloadData()
            case 1:
            selectedAccounts = accounts2
            filteredAccounts = selectedAccounts
            searchController.isActive = false
            tableView.reloadData()
            default:
                break
            }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredAccounts = selectedAccounts.filter { (account: Account) -> Bool in
            return account.name.lowercased().contains(searchText.lowercased()) || account.iban.contains(searchText)
        }
      tableView.reloadData()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredAccounts.count
        }
        
        return selectedAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        let account: Account
        if isFiltering {
            account = filteredAccounts[indexPath.row]
        } else {
            account = selectedAccounts[indexPath.row]
        }
        cell.nameLabel.text = account.name
        cell.priceLabel.text = account.price + "₺"
        cell.dateLabel.text = account.date
        cell.ibanLabel.text = account.iban
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

extension ViewController {
    func loadData() {
        NetworkService().fetchData(url: URL(string: "https://raw.githubusercontent.com/kadanur/SearchApp/main/SearchApp/data1.json")!) { result in
            if let result = result {
                for i in result{
                    self.accounts1.append(i)
                }
                DispatchQueue.main.async {
                    if self.segmentedControl.selectedSegmentIndex == 0 {
                        self.selectedAccounts = self.accounts1
                        self.filteredAccounts = self.selectedAccounts
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        NetworkService().fetchData(url: URL(string: "https://raw.githubusercontent.com/kadanur/SearchApp/main/SearchApp/data2.json")!) { result in
            if let result = result {
                for i in result {
                    self.accounts2.append(i)
                }
                DispatchQueue.main.async {
                    if self.segmentedControl.selectedSegmentIndex == 1 {
                        self.selectedAccounts = self.accounts2
                        self.filteredAccounts = self.selectedAccounts
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
