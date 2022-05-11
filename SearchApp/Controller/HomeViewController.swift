//
//  ViewController.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 29.04.2022.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = AccountListViewModel()
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchContainer: UIView!
    lazy var customSearchController = CustomSearchController(self, parentView: searchContainer)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeVc loaded")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountCell.self, forCellReuseIdentifier: "AccountCell")
        viewModel.fetchData(tableView: tableView)
        setupUI()
    }
    
    func setupUI() {
        customSearchController.delegate = self
        customSearchController.tableViewManager(tableView)
        if #available(iOS 13.0, *) {
            segmentedControl.selectedSegmentTintColor = UIColor(hexRGBString: "#0184d4")
        } else {
            segmentedControl.tintColor = UIColor(hexRGBString: "#0184d4")
        }
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(hexRGBString: "#0184d4")], for: .normal)
    }
    @IBAction func segmentControlChange(_ sender: UISegmentedControl) {
        viewModel.tableType = TableType(rawValue: sender.selectedSegmentIndex) ?? .table1
        viewModel.fetchData(tableView: tableView)
    }
    
}

extension HomeViewController: CustomSearchControllerDelegate{
    func update(text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if trimmedText.isEmpty {
            viewModel.filteredAccountsViewModel = viewModel.accountsViewModel
        } else {
            viewModel.filteredAccountsViewModel = viewModel.accountsViewModel.filter({ account in
                return account.name.lowercased().contains(trimmedText) || account.iban.contains(trimmedText)
            })
        }
        tableView.reloadData()
    }
}
 
  
    // MARK: Table View Options

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countOfCharactersViewModel()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AccountCell", owner: self, options: nil)?.first as! AccountCell
             cell.preservesSuperviewLayoutMargins = false
             cell.separatorInset = UIEdgeInsets.zero
             cell.layoutMargins = UIEdgeInsets.zero
        let account: AccountViewModel = viewModel.getAccountViewModel(at: indexPath.row)
        cell.nameLabel?.text = account.name
        cell.ibanLabel.text = account.iban
             return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = SecondViewController()
        secondVC.modalPresentationStyle = .custom
        secondVC.transitioningDelegate = self
        present(secondVC, animated: true)
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

