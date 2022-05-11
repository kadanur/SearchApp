//
//  MenuCell.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import Foundation

import UIKit
import SnapKit

class MenuCell: UITableViewCell {
    
    let cellTitleLabel: UILabel = UILabel()
    
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
        addSubview(cellTitleLabel)
        makeCellTitleLabel()
    }
}

extension MenuCell {
    
    func makeCellTitleLabel() {
        cellTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
