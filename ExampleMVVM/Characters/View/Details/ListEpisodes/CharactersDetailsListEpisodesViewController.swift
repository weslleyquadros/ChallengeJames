//
//  CharactersDetailsViewController.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 02/12/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import UIKit

class CharactersDetailsListEpisodesViewController: UIViewController {
    var viewModel = CharacterDetailsListEpisodesViewModel()
    var loadingIndicator = UIActivityIndicatorView()
    internal let tableView = UITableView(frame: .zero, style: .grouped)
    var contentView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavidation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.background_card
        self.addLoading()
        self.setupTableView()
        
    }
    
    private func setupNavidation() {
        navigationController?.navigationBar.accessibilityIdentifier = "ListEpisodeNavigatioBar"
        navigationItem.title = NSLocalizedString("titleListEpisodes", comment: "")
        let button = UIBarButtonItem(title: NSLocalizedString("leftButtonBar", comment: ""), style: .done, target: self, action: #selector(didTouchClose))
        navigationItem.leftBarButtonItem = button
        navigationItem.leftBarButtonItem?.accessibilityIdentifier = "ListEpisodeButtonClose"
    }
    
    @objc func didTouchClose() {
        dismiss(animated: true)
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func addLoading() {
        loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.center = self.view.center
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        self.view.addSubview(loadingIndicator)
        self.view.bringSubviewToFront(loadingIndicator)
    }
    
    func setupTableView(){
        tableView.accessibilityIdentifier = "ListEpisodeTable"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UIScreen.main.bounds.height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .background_card
        self.tableView.isAccessibilityElement = true
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        
        tableView.register(CharacterDetailsListEpisodeCell.self, forCellReuseIdentifier: CharacterDetailsListEpisodeCell.identifier)
        tableView.register(CharacterDetailsHeaderListEpisodeCell.self, forCellReuseIdentifier: CharacterDetailsHeaderListEpisodeCell.identifier)
        
        self.view.addSubview(self.tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.anchor(
            top: (self.view.topAnchor, 0),
            left: (self.view.leftAnchor, 0),
            right: (self.view.rightAnchor, 0),
            bottom: (self.view.bottomAnchor, 0)
        )
    }
}

extension CharactersDetailsListEpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listEpisodes.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let defaultCell = UITableViewCell()
        
        
        if index == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailsHeaderListEpisodeCell.identifier) as? CharacterDetailsHeaderListEpisodeCell else { return defaultCell }
            cell.selectionStyle = .none
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailsListEpisodeCell.identifier) as? CharacterDetailsListEpisodeCell else { return defaultCell }
            
            cell.setupData(episode: viewModel.listEpisodes[indexPath.row - 1].episode, name: viewModel.listEpisodes[indexPath.row - 1].name)
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
