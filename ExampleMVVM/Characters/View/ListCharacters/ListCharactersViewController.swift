//
//  ListCharactersViewController.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 27/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import UIKit

class ListCharactersViewController: UIViewController {
    var viewModel = ListCharactersViewModel()
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
        setupNavidation()
        self.view.backgroundColor = UIColor.background_card
        
        if UserDefaults.standard.object(forKey: "favList") != nil {
            
            viewModel.favListArray = NSMutableArray.init(array: UserDefaults.standard.object(forKey: "favList") as? [Int] ?? [Int]())
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.setupTableView()
        self.setupEmptyView()
        self.addLoading()
        self.getCharacter()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("searchBarPlaceholder", comment: "")
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
        
    private func setupNavidation() {
        navigationItem.title = NSLocalizedString("titleHome", comment: "")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.accessibilityIdentifier = "HomeNavigationBar"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "listFavorites.png"), style: .plain, target: self, action: #selector(handleFavorite))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.text_titleLabel
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "FavoritesButtonNavigation"
        
        navigationItem.largeTitleDisplayMode = .automatic
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor:UIColor.blue,
             NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)]
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UIScreen.main.bounds.height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.accessibilityIdentifier = "HomeTable"
        self.view.addSubview(self.tableView)
        
        /* Insert constraint without extension for the purpose of demonstrating how to work without using extension */
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.tableView.isAccessibilityElement = true
    }
    
    func setupEmptyView() {
        view.addSubview(self.contentViewEmpty)
        contentViewEmpty.addSubview(emptyIcon)
        contentViewEmpty.addSubview(emptyLabel)
        
        /* Insert constraint without extension for the purpose of demonstrating how to work without using extension */
        contentViewEmpty.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        contentViewEmpty.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        contentViewEmpty.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        contentViewEmpty.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        emptyIcon.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        emptyIcon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        emptyLabel.topAnchor.constraint(equalTo: self.emptyIcon.bottomAnchor, constant: 10).isActive = true
        emptyLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 22).isActive = true
        emptyLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -22).isActive = true
    }
    
    private func addLoading() {
        loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.center = self.view.center
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        self.view.addSubview(loadingIndicator)
        self.view.bringSubviewToFront(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        viewModel.listFavoriteSeach = viewModel.listCharacter.filter { (c: Character) -> Bool in
        return c.name.lowercased().contains(searchText.lowercased())
      }
      
      self.updateUI()
      self.tableView.reloadData()
    }
    
    func getCharacter() {
        loadingIndicator.startAnimating()
        
        viewModel.fetchCharacters{ [weak self] characters in
            guard let self = self else{return}
            switch characters {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.updateUI()
                    self.loadingIndicator.stopAnimating()
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("buttonTryAgain", comment: ""), style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            self.getCharacter()
                        default: break
                        }
                    }))
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("buttonCancel", comment: ""), style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            case .success(let data) :
                DispatchQueue.main.async {
                    self.updateUI()
                    self.viewModel.listCharacter = data.results
                    self.tableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                }
            }
        }
    }
    
    @objc func handleFavorite() {
        let vc = ListCharactersFavoritesViewController()
        vc.viewModel.listCharacter = viewModel.listCharacter
        self.navigationController?.show(vc, sender: self)
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            if self.viewModel.listCharacter.isEmpty {
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

    // MARK: - Table view data source and delegate
extension ListCharactersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return viewModel.listFavoriteSeach.count
        }
        
        return viewModel.listCharacter.count > 0 ? viewModel.listCharacter.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let defaultCell = UITableViewCell()
        var character: Character!

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as? ListTableViewCell else { return defaultCell }
        
        
        
        if isFiltering && viewModel.listFavoriteSeach.count > 0 {
            character = viewModel.listFavoriteSeach[index]
        } else if viewModel.listCharacter.count > 0 {
            character = viewModel.listCharacter[index]
        }
        
        var favIcon = UIImage()
        
        if viewModel.favListArray.contains(character.id) {
            favIcon = #imageLiteral(resourceName: "favoriteBlack.png")
            
        } else{
            favIcon = #imageLiteral(resourceName: "favorite")
        }
        
        cell.setupData(id: character.id, name: character.name, location: character.location.name, image: character.image, favIcon: favIcon)
        cell.selectionStyle = .none
        cell.delegate = self
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = "MyCellId"
   
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CharacterDetailsViewController()
        var character: Character!
        
        if isFiltering && viewModel.listFavoriteSeach.count > 0 {
            character = viewModel.listFavoriteSeach[indexPath.row]
        } else if viewModel.listCharacter.count > 0 {
            character = viewModel.listCharacter[indexPath.row]
        }
        
        vc.viewModel.character = character
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

    // MARK: - ListTableViewCellDelegate
extension ListCharactersViewController: ListTableViewCellDelegate {
    
    func buttonTapped(cell: ListTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        
        let id = viewModel.listCharacter[indexPath.row].id
        
        if viewModel.favListArray.contains(id) {
            viewModel.favListArray.remove(id)
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "favorite.png"), for: .normal)
            
        } else {
            viewModel.favListArray.add(id)
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "favoriteBlack.png"), for: .normal)
        }
        
        UserDefaults.standard.set(viewModel.favListArray, forKey: "favList")
    }
}

    // MARK: - UISearchResultsUpdating
extension ListCharactersViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
