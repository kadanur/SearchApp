//
//  HomeViewModel.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import Foundation
import UIKit

enum TableType: Int {
    case table1 = 0
    case table2 = 1
}

class AccountListViewModel {
    var accountsViewModel = [AccountViewModel]()
    var filteredAccountsViewModel = [AccountViewModel]()
    var tableType: TableType = .table1
    
    func fetchData(tableView: UITableView) {
        accountsViewModel.removeAll()
        filteredAccountsViewModel.removeAll()
        switch tableType {
        case .table1:
            NetworkService.fetchData(url: URL(string: "https://raw.githubusercontent.com/kadanur/SearchApp/srchcntrllr/SearchApp/data1.json")!) { result in
                if let result = result {
                    for i in result {
                        let item = AccountViewModel.init(account: i)
                        self.accountsViewModel.append(item)
                    }
                    self.filteredAccountsViewModel = self.accountsViewModel
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        case .table2:
            NetworkService.fetchData(url: URL(string: "https://raw.githubusercontent.com/kadanur/SearchApp/main/SearchApp/data2.json")!) { result in
                if let result = result {
                    for i in result {
                        let item = AccountViewModel.init(account: i)
                        self.accountsViewModel.append(item)
                    }
                    self.filteredAccountsViewModel = self.accountsViewModel
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
    func getAccountViewModel(at index: Int) -> AccountViewModel {
        return filteredAccountsViewModel[index]
    }
    
    func countOfCharactersViewModel() -> Int {
        return filteredAccountsViewModel.count
    }
}

struct AccountViewModel {
    var account: Account
    
    var name : String {
        return account.name
    }
    
    var date: String {
        return account.date
    }
    
    var iban: String {
        return account.iban
    }
    
    var price: String {
        return account.price
    }
}
