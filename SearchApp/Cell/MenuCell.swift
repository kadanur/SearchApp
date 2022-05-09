//
//  MenuCell.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import Foundation

import UIKit
import SnapKit

protocol DismissButtonDelegate {
    func dismissVC()
}

class MenuCell: UITableViewCell {
    
    let cellTitleLabel: UILabel = UILabel()
    let dismissButton = UIImageView()
    var delegate: DismissButtonDelegate?
    
    enum MenuCellIdentifier: String {
        case identifier = "MenuCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetup() {
        dismissButton.image = UIImage(named: "xButton")
        addSubview(cellTitleLabel)
        contentView.addSubview(dismissButton)
        makeCellTitleLabel()
        makeDismissButton()
        dismissButton.isUserInteractionEnabled = true
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissButtonAction))
        dismissButton.addGestureRecognizer(dismissGesture)
    }
    
    @objc func dismissButtonAction() {
        print("Dismiss Button Clicked")
        delegate?.dismissVC()
    }
}

extension MenuCell {
    
    func makeCellTitleLabel() {
        cellTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func makeDismissButton() {
        dismissButton.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
}
