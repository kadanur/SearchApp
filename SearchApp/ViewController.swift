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
    @IBOutlet weak var searchBar: UISearchBar!
    var accounts1 = [Account]() // İlk Veri
    var accounts2 = [Account]() // İkinci Veri
    var selectedAccounts = [Account]() // Seçilen Veri
    var filteredAccounts = [Account]() // Filtrelenen Veri
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VC loaded")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        loadData()
    }
    
    @IBAction func segmentedControlFunc(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
            {
            case 0:
            selectedAccounts = accounts1
            filteredAccounts = selectedAccounts
            tableView.reloadData()
            case 1:
            selectedAccounts = accounts2
            filteredAccounts = selectedAccounts
            tableView.reloadData()
            default:
                break
            }
    }
    
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = filteredAccounts[indexPath.row].name
        cell.priceLabel.text = filteredAccounts[indexPath.row].price + "₺"
        cell.dateLabel.text = filteredAccounts[indexPath.row].date
        cell.ibanLabel.text = filteredAccounts[indexPath.row].iban
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         //BUG I-İ Türkçe karakter bug
         filteredAccounts = []
         if searchText == ""{
             filteredAccounts = selectedAccounts
             print("Boşş")
         }
        
        for i in selectedAccounts {
            if i.name.uppercased().contains(searchText.uppercased()) || i.iban.contains(searchText) {
                filteredAccounts.append(i)
            }
        }

        self.tableView.reloadData()
        print(searchText)
        print(self.filteredAccounts)
     }
}
