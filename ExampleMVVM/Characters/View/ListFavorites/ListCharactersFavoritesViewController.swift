//
//  ListCharactersFavoritesViewController.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 29/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import UIKit

class ListCharactersFavoritesViewController: UIViewController {
    var viewModel = ListFavoritesViewModel()
    let tableView = UITableView(frame: .zero, style: .plain)
    var loadingIndicator = UIActivityIndicatorView()
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    //MARK: View empty
    private let contentViewEmpty: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.text_label
        label.text = NSLocalizedString("emptyLabel", comment: "")
        label.font = UIFont(name:"gotham-bold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let emptyIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "api-Icon")
        return imageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavidation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.background_card
        self.setupSearchController()
        self.setupTableView()
        self.setupEmptyView()
        self.getFavorites()
    }
    
    private func getFavorites() {
        if UserDefaults.standard.object(forKey: "favList") != nil {
            viewModel.favListArray = NSMutableArray.init(array: UserDefaults.standard.object(forKey: "favList") as? [Int] ?? [Int]())
            
            debugPrint(viewModel.favListArray)
        }
        
        viewModel.listCharacter.forEach { item in
            viewModel.favListArray.forEach { array in
                if item.id == array as? Int {
                    viewModel.listCharacterCell.append(item)
                }
            }
            
        }
        self.updateUI()
        self.tableView.reloadData()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("searchBarPlaceholder", comment: "")
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupNavidation() {
        navigationItem.title = NSLocalizedString("titleFavorite", comment: "")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.accessibilityIdentifier = "NavigationBarFavorites"
        navigationItem.largeTitleDisplayMode = .automatic
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.blue,
             NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)]
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UIScreen.main.bounds.height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ListFavoritesTableViewCell.self, forCellReuseIdentifier: ListFavoritesTableViewCell.identifier)
        
        self.view.addSubview(self.tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.anchor(
            top: (view.safeAreaLayoutGuide.topAnchor, 0),
            left: (view.leftAnchor, 0),
            right: (view.rightAnchor, 0),
            bottom: (view.bottomAnchor, 0)
        )
        
        self.tableView.isAccessibilityElement = true
    }
    
    func setupEmptyView() {
        view.addSubview(self.contentViewEmpty)
        contentViewEmpty.addSubview(emptyIcon)
        contentViewEmpty.addSubview(emptyLabel)
        
        contentViewEmpty.anchor(
            top: (view.safeAreaLayoutGuide.topAnchor, 0),
            left: (view.leftAnchor, 0),
            right: (view.rightAnchor, 0),
            bottom: (view.bottomAnchor, 0)
        )
        
        emptyIcon.anchor(
            centerX: (view.centerXAnchor, 0),
            centerY: (view.centerYAnchor, 0)
        )
        
        emptyLabel.anchor(
            top: (emptyIcon.bottomAnchor, 10),
            left: (view.leftAnchor, 22),
            right: (view.rightAnchor, 22)
        )
    }
    
    func filterContentForSearchText(_ searchText: String) {
        viewModel.listFavoriteSeach = viewModel.listCharacterCell.filter { (c: Character) -> Bool in
        return c.name.lowercased().contains(searchText.lowercased())
      }
      
      self.updateUI()
      self.tableView.reloadData()
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            if self.viewModel.listCharacterCell.isEmpty {
                self.contentViewEmpty.isHidden = false
                return
            } else {
                self.contentViewEmpty.isHidden = true
            }
            
            if self.isFiltering {
                
                if self.viewModel.listFavoriteSeach.isEmpty {
                    self.contentViewEmpty.isHidden = false
                }
            } else {
                self.contentViewEmpty.isHidden = true
            }
        }
    }
}
    // MARK: - Table view data source
extension ListCharactersFavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
          return viewModel.listFavoriteSeach.count
        }
        return viewModel.listCharacterCell.count > 0 ? viewModel.listCharacterCell.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let defaultCell = UITableViewCell()
           
        if viewModel.listCharacterCell.isEmpty {
            return defaultCell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListFavoritesTableViewCell.identifier) as? ListFavoritesTableViewCell else { return defaultCell }
           
        var favorite: Character
        
        if isFiltering {
          favorite = viewModel.listFavoriteSeach[index]
        } else {
          favorite = viewModel.listCharacterCell[index]
        }
        
        cell.setupData(id: favorite.id, name: favorite.name, location: favorite.location.name, image: favorite.image)
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CharacterDetailsViewController()
        var favorite: Character
        if isFiltering {
          favorite = viewModel.listFavoriteSeach[indexPath.row]
        } else {
          favorite = viewModel.listCharacterCell[indexPath.row]
        }
        vc.viewModel.character = favorite
        self.navigationController?.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return 160
            default:
                return 120
            }
        }
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
// MARK: - UISearchResultsUpdating
extension ListCharactersFavoritesViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
