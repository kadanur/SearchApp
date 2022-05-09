//
//  CustomSearchBar.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import Foundation
import UIKit

class CustomSearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeTextField() {
        let field = searchTextField
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(red: CGFloat(182/255.0), green: CGFloat(198/255.0), blue: CGFloat(215/255.0), alpha: CGFloat(1.0)).cgColor
        //sets text Color
        field.textColor = UIColor(red: CGFloat(120/255.0), green: CGFloat(144/255.0), blue: CGFloat(156/255.0), alpha: CGFloat(1.0))
        field.backgroundColor = .white
        field.font = UIFont.systemFont(ofSize: 14)
        field.layer.masksToBounds = true
        field.returnKeyType = .search

        let placeholderString = NSAttributedString(string: "Kişi Ara", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: CGFloat(120/255.0), green: CGFloat(144/255.0), blue: CGFloat(156/255.0), alpha: CGFloat(1.0))])

        field.attributedPlaceholder = placeholderString

        let iconView = field.leftView as! UIImageView
        iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = UIColor(red: CGFloat(1/255.0), green: CGFloat(132/255.0), blue: CGFloat(212/255.0), alpha: CGFloat(1.0))
    
        if let backgroundview = field.subviews.first {
            backgroundview.backgroundColor = .white
        }
    }
    
    func setConstraints(field: UISearchTextField, searchView: UIView) {
        
                    field.translatesAutoresizingMaskIntoConstraints = false




                        NSLayoutConstraint.activate([
                            field.leadingAnchor.constraint(equalTo: searchView.leadingAnchor,constant: 0),
                            field.topAnchor.constraint(equalTo: searchView.topAnchor,constant: 0),
                            field.bottomAnchor.constraint(equalTo: searchView.bottomAnchor,constant: 0),
                            field.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: 0)
                        ])

    }
}






