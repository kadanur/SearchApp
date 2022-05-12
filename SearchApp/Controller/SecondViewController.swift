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
    
    private let lineView = UIView()
    private let titleView = UIView()
    private let titleLabel = UILabel()
    private let dismissButton = UIImageView()
    private let tableView = UITableView()
//        static let menuArray = ["Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer", "Manuel Transfer", "Scan & Pay Transfer", "Own Transfer"]
    static let menuArray = ["Manuel Transfer", "Scan & Pay Transfer", "Own Transfer"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        designSetup()
    }
    
    @objc func dismissButtonAction() {
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
        view.backgroundColor = .white
        view.addSubview(titleView)
        view.addSubview(tableView)
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(dismissButton)
        titleView.addSubview(lineView)
        titleView.backgroundColor = .white
        
        if SecondViewController.menuArray.count <= PresentationController.listedCells {
            self.tableView.isScrollEnabled = false
        } else {
            self.tableView.isScrollEnabled = true
        }
        
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
        
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor(red: CGFloat(224/255.0), green: CGFloat(224/255.0), blue: CGFloat(224/255.0), alpha: CGFloat(1.0)).cgColor
        
        lineView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalToSuperview()
            }
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

