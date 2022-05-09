//
//  UISearchBar+Extensions.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import UIKit

public extension UISearchBar {
    
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            return value(forKey: "searchField") as? UITextField
        }
    }

}
