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
    let searchController = CustomSearchController(searchResultsController: nil)
    @IBOutlet weak var searchView: UIView!
    
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
    
    // MARK: View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VC loaded")
        setup()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        setupSearchBarSize()
    }
    
    // MARK: Segmented Control Function
    
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
    
    // MARK: Filter Function
    
    func filterContentForSearchText(_ searchText: String) {
        filteredAccounts = selectedAccounts.filter { (account: Account) -> Bool in
            return account.name.lowercased().contains(searchText.lowercased()) || account.iban.contains(searchText)
        }
      tableView.reloadData()
    }
}

    // MARK: Table View Options

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredAccounts.count
        }
        return selectedAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AccountCell", owner: self, options: nil)?.first as! AccountCell
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        let account: Account
        if isFiltering {
            account = filteredAccounts[indexPath.row]
        } else {
            account = selectedAccounts[indexPath.row]
        }
        cell.nameLabel?.text = account.name.uppercased()
        cell.ibanLabel.text = account.iban
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
}

    // MARK: Search Bar Options

extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func setupSearchBarSize(){
//         self.searchController.searchBar.frame.size.width = self.view.frame.size.width
        let searchField = searchController.searchBar.value(forKey: "searchField") as? UITextField
        
        if let field = searchField {
            self.searchController.searchBar.setConstraints(field: field as! UISearchTextField, searchView: searchView)
        }
    }
}

    // MARK: Load Data

extension ViewController {
    func loadData() {
        NetworkService().fetchData(url: URL(string: "https://raw.githubusercontent.com/kadanur/SearchApp/srchcntrllr/SearchApp/data1.json")!) { result in
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

    // MARK: Config for First Launch

extension ViewController: UISearchControllerDelegate {
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountCell.self, forCellReuseIdentifier: "AccountCell")
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
//        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
                searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.autoresizingMask = .flexibleRightMargin
                searchController.searchBar.delegate = self
                searchController.delegate = self
                definesPresentationContext = true
        searchView.addSubview(searchController.searchBar)
        loadData()
    }
    
    func setupUI() {
        searchView.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = UIColor(red: CGFloat(1/255.0), green: CGFloat(132/255.0), blue: CGFloat(212/255.0), alpha: CGFloat(1.0))
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(red: CGFloat(1/255.0), green: CGFloat(132/255.0), blue: CGFloat(212/255.0), alpha: CGFloat(1.0))], for: .normal)
        
        
        let searchField = searchController.searchBar.value(forKey: "searchField") as? UITextField
        
        if let field = searchField {
            self.searchController.searchBar.setConstraints(field: field as! UISearchTextField, searchView: searchView)
        }
    }
}
