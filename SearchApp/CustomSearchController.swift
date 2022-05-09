//
//  CustomSearchController.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import Foundation
import UIKit

protocol CustomSearchControllerDelegate: AnyObject {
    func update(text: String)
}

class CustomSearchController: UIViewController {

    weak var delegate: CustomSearchControllerDelegate?
    private lazy var searchBar = CustomSearchBar()
    private var tableViewToManage: UITableView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    init(_ controller: UIViewController, parentView: UIView) {
        super.init(nibName: nil, bundle: nil)
        commonInit(controller, parentView: parentView)
    }
    
    public func tableViewManager(_ tableView: UITableView) {
        tableViewToManage = tableView
    }
    
    public func resignResponder(resetTextField: Bool = false) {
        if resetTextField {
            searchBar.text = nil
        }
        searchBar.resignFirstResponder()
    }
    
    private func attachKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowAction(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideAction(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func commonInit(_ controller: UIViewController? = nil, parentView: UIView? = nil) {
        guard let controller = controller, let parentView = parentView else { return }
        controller.addChild(self)
        parentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0.0).isActive = true
        view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: 0.0).isActive = true
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0.0).isActive = true
        view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0.0).isActive = true
        parentView.layoutIfNeeded()
        didMove(toParent: controller)
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.sizeToFit()
        parentView.heightAnchor.constraint(equalToConstant: searchBar.frame.size.height).isActive = true
        attachKeyboardObservers()
    }
    
    @objc
    private func keyboardWillShowAction(_ sender: Notification) {
        guard let tableView = tableViewToManage else { return }
        var keyboardHeight = sender.getKeyboardAnimationData().2
        if let window = UIApplication.shared.keyWindow {
            keyboardHeight -= window.safeAreaInsets.bottom
        }
        tableView.contentInset.bottom = keyboardHeight
        tableView.scrollIndicatorInsets.bottom = keyboardHeight
    }
    
    @objc
    private func keyboardWillHideAction(_ sender: Notification) {
        guard let tableView = tableViewToManage else { return }
        tableView.contentInset.bottom = 0.0
        tableView.scrollIndicatorInsets.bottom = 0.0
    }
}

extension CustomSearchController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.update(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
