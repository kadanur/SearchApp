//
//  CustomSearchController.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import Foundation
import UIKit

class CustomSearchController: UISearchController {

    private lazy var customSearchBar = CustomSearchBar()

    override var searchBar: CustomSearchBar {
        return customSearchBar
    }
}
