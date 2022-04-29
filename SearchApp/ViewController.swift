//
//  ViewController.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 29.04.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var accounts1 = [Account]()
    var accounts2 = [Account]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VC loaded")
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        NetworkService().fetchData(url: URL(string: "https://raw.githubusercontent.com/kadanur/SearchApp/main/SearchApp/data1.json")!) { result in
            if let result = result {
                for i in result{
                    self.accounts1.append(i)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = accounts1[indexPath.row].name
        cell.priceLabel.text = accounts1[indexPath.row].price + "₺"
        cell.dateLabel.text = accounts1[indexPath.row].date
        cell.ibanLabel.text = accounts1[indexPath.row].iban
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
    
}
