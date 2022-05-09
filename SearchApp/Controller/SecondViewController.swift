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
    private let topView = UIView()
//    private let menuArray = ["YENİ TRANSFER", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer"]
    private let menuArray = ["YENİ TRANSFER", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer"]
    private let cellHeight = 52
    private var cellCount = 0
    
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
        
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissSecondVC))
        self.topView.isUserInteractionEnabled = true
        self.topView.addGestureRecognizer(tapDismiss)
    }
    
    func designSetup() {
        cellCount = menuArray.count
        let wantedHeightMultiplier = (Int(self.view.bounds.height) / 2)
        let modForWantedTableViewHeight = (wantedHeightMultiplier / 2) % cellHeight
        var wantedTableViewHeight = wantedHeightMultiplier - modForWantedTableViewHeight
        let listedCells = wantedTableViewHeight / cellHeight
        
        if menuArray.count <= listedCells {
            self.tableView.isScrollEnabled = false
            wantedTableViewHeight = menuArray.count * cellHeight
        } else {
            self.tableView.isScrollEnabled = true
            wantedTableViewHeight = listedCells * cellHeight
        }
        
        self.view.addSubview(topView)
        self.view.addSubview(tableView)
        view.layer.opacity = 1
        topView.backgroundColor = .black
        topView.layer.opacity = 0.5
        
        tableView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(wantedTableViewHeight)
        }
        
        topView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
        }
    }
    
    @objc func dismissSecondVC() {
        self.dismiss(animated: true)
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.MenuCellIdentifier.identifier.rawValue) as! MenuCell
        cell.cellTitleLabel.text = menuArray[indexPath.row]
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
        return CGFloat(cellHeight)
    }
}

extension SecondViewController: DismissButtonDelegate {
    func dismissVC() {
        dismiss(animated: true)
    }
}
