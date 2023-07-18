//
//  ViewController.swift
//  DemoApp
//
//  Created by Satyendra Chauhan on 17/07/23.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
  
    // MARK: - Variables
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        return tableView
    }()
    
    var viewModel: HomeViewModelType = HomeViewModel()
    var isLoadingData: Bool = false
    var currentPage = 1
    // MARK: - overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 4/255, green: 203/255, blue: 168/255, alpha: 1)
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        self.view.backgroundColor = .white
        viewSetup()
        viewModel.getContacts { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    fileprivate func viewSetup() {
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    fileprivate func loadNextPage() {
        guard !isLoadingData else {
            return
        }
        
        isLoadingData = true
        let nextPage = currentPage + 1
        viewModel.getContacts(pageNumber: nextPage) { [weak self] in
            self?.tableView.reloadData()
            self?.isLoadingData = false
            self?.currentPage = nextPage
        }
        
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfContacts ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier) as? ContactTableViewCell {
            cell.dataSource = viewModel.contact(at: indexPath.row)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex && !isLoadingData {
            loadNextPage()
        }
    }
}
