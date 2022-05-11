//
//  SecondViewController.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import Foundation
import UIKit
import SnapKit

class SecondViewController: UIViewController {
    

 
    private let tableView = UITableView()
    static let menuArray = ["YENİ TRANSFER", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer"]
//    static let menuArray = ["YENİ TRANSFER", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        designSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 20 // Set As you want
        tableView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    func setup() {
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.MenuCellIdentifier.identifier.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
        
//        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissSecondVC))
     
    }
    
    func designSetup() {
      
        
        if SecondViewController.menuArray.count <= AppDelegate.listedCells {
            self.tableView.isScrollEnabled = false
            AppDelegate.wantedTableViewHeight = SecondViewController.menuArray.count * AppDelegate.cellHeight
        } else {
            self.tableView.isScrollEnabled = true
            AppDelegate.wantedTableViewHeight = AppDelegate.listedCells * AppDelegate.cellHeight
        }
        
        
        self.view.addSubview(tableView)
        view.layer.opacity = 1
      
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(AppDelegate.wantedTableViewHeight)
        }
        
      
    }
    
    @objc func dismissSecondVC() {
        self.dismiss(animated: true)
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SecondViewController.menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.MenuCellIdentifier.identifier.rawValue) as! MenuCell
        cell.cellTitleLabel.text = SecondViewController.menuArray[indexPath.row]
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.delegate = self
        if indexPath.row == 0  {
            cell.cellTitleLabel.font = UIFont(name: "OpenSans-SemiBold", size: 15)
            cell.dismissButton.isHidden = false
        } else {
            cell.cellTitleLabel.font = UIFont(name: "OpenSans-Regular", size: 15)
            cell.dismissButton.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AppDelegate.cellHeight)
    }
}

extension SecondViewController: DismissButtonDelegate {
    func dismissVC() {
        dismiss(animated: true)
    }
}
