//
//  CustomSearchBar.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import Foundation
import UIKit

import UIKit

class CustomSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        customizeTextField()
    }
    
    private func customizeTextField() {
        searchBarStyle = .minimal
        isTranslucent = false
        barTintColor = .white
        guard let field = self.textField else { return }
        tintColor = UIColor(hexRGBString: "#0184d4")
        field.layer.cornerRadius = 8.0
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor(hexRGBString: "#b6c6d7").cgColor
        //sets text Color
        field.textColor = UIColor(hexRGBString: "#78909c")
        field.tintColor = UIColor(hexRGBString: "#0184d4")
        field.backgroundColor = .white
        field.font = UIFont.systemFont(ofSize: 14.0)
        field.returnKeyType = .search
        let placeholderString = NSAttributedString(string: "Kişi Ara",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexRGBString: "#78909c")])
        field.attributedPlaceholder = placeholderString
        let iconView = field.leftView as! UIImageView
        iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = UIColor(hexRGBString: "#0184d4")
    }
}






