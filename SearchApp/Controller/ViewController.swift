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

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

    // MARK: Load Data

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

    // MARK: Config for First Launch

extension ViewController {
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountCell.self, forCellReuseIdentifier: "AccountCell")
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchView.addSubview(searchController.searchBar)
        loadData()
    }
    
    func setupUI() {
        searchView.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = UIColor(red: CGFloat(1/255.0), green: CGFloat(132/255.0), blue: CGFloat(212/255.0), alpha: CGFloat(1.0))
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(red: CGFloat(1/255.0), green: CGFloat(132/255.0), blue: CGFloat(212/255.0), alpha: CGFloat(1.0))], for: .normal)
        
        let searchField = searchController.searchBar.value(forKey: "searchField") as? UITextField
        searchController.searchBar.backgroundColor = .white
        searchController.searchBar.backgroundImage = UIImage()

        if let field = searchField {
            field.layer.cornerRadius = 8
            field.layer.borderWidth = 1
            field.layer.borderColor = UIColor(red: CGFloat(182/255.0), green: CGFloat(198/255.0), blue: CGFloat(215/255.0), alpha: CGFloat(1.0)).cgColor
            //sets text Color
            field.textColor = UIColor(red: CGFloat(120/255.0), green: CGFloat(144/255.0), blue: CGFloat(156/255.0), alpha: CGFloat(1.0))
            field.backgroundColor = .white
            field.font = UIFont.systemFont(ofSize: 14)
            field.layer.masksToBounds = true
            field.returnKeyType = .search

            let placeholderString = NSAttributedString(string: "Kişi Ara", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: CGFloat(120/255.0), green: CGFloat(144/255.0), blue: CGFloat(156/255.0), alpha: CGFloat(1.0))])
            field.attributedPlaceholder = placeholderString

            let iconView = field.leftView as! UIImageView
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = UIColor(red: CGFloat(1/255.0), green: CGFloat(132/255.0), blue: CGFloat(212/255.0), alpha: CGFloat(1.0))

            if let backgroundview = field.subviews.first {
                backgroundview.backgroundColor = .white
            }
        }
    }
}
