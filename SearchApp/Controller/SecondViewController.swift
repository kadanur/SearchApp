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
    
    private let titleView = UIView()
    private let titleLabel = UILabel()
    private let dismissButton = UIImageView()
    private let tableView = UITableView()
    static let menuArray = ["Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer"]
    //    static let menuArray = ["YENİ TRANSFER", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        designSetup()
    }
    
    
    @objc func dismissButtonAction() {
        print("Dismiss Button Clicked")
        self.dismiss(animated: true)
    }
    
    func setup() {
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.MenuCellIdentifier.identifier.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
        
        dismissButton.isUserInteractionEnabled = true
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissButtonAction))
        dismissButton.addGestureRecognizer(dismissGesture)
    }
    
    func designSetup() {
        
        
        if SecondViewController.menuArray.count <= PresentationController.listedCells {
            self.tableView.isScrollEnabled = false
            PresentationController.wantedTableViewHeight = SecondViewController.menuArray.count * PresentationController.cellHeight
        } else {
            self.tableView.isScrollEnabled = true
            PresentationController.wantedTableViewHeight = PresentationController.listedCells * PresentationController.cellHeight
        }
        
        //   tableView.tableHeaderView = titleView
        view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(dismissButton)
        titleView.backgroundColor = .white
        titleView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(PresentationController.cellHeight)
        }
        
        titleLabel.text = "YENİ TRANSFER"
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: 15)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        dismissButton.image = UIImage(named: "xButton")
        dismissButton.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        self.view.addSubview(tableView)
        view.layer.opacity = 1
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
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
        cell.cellTitleLabel.font = UIFont(name: "OpenSans-Regular", size: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(PresentationController.cellHeight)
    }
}

