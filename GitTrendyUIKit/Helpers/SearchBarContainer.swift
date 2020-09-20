//
//  SearchBarContainer.swift
//  GitTrendyUIKit
//
//  Created by Miroslav Djukic on 20/09/2020.
//

import UIKit

class SearchBarContainer: UIView {
    // MARK: - Properties
    public var searchBar = UISearchBar()
    
    private let searchToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(named: "starColor")
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }()
    
    // MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    private func customInit() {
        addSubviews()
        addConstraints()
        setup()
    }
    
    private func setup() {
        searchBar.placeholder = "Search"
        searchBar.inputAccessoryView = searchToolBar
        searchBar.barTintColor = UIColor(named: "searchBarColor")
        searchBar.searchTextField.backgroundColor = UIColor(named: "primaryColor")
    }
    
    @objc func dismissPicker() {
        self.endEditing(true)
    }
    
    private func addConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
            searchBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true

    }
    
    private func addSubviews() {
        self.addSubview(searchBar)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    

}
