//
//  CharactersViewController.swift
//  Mavel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit

class CharactersViewController: UIViewController {

    // MARK: - IBOutlets
    // Setting IBOutlets as private to not be accessed only by it self
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Variables
    private var viewModel: CharactersViewModel!
    
    // MARK: - Init
    static func create(with viewModel: CharactersViewModel) -> CharactersViewController {
        let view = CharactersViewController.loadFromNib()
        view.viewModel = viewModel
        return view
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        viewModel.viewDidLoad()
        bind(to: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Binding
    private func bind(to viewModel: CharactersViewModel) {
        viewModel.characters.observe(on: self) { [weak self] _ in
            self?.updateItems()
        }
    }
    
    private func updateItems() {
        tableView.reloadData()
    }

    // MARK: - Setup
    private func setupViewController() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "CharacterShimmerTableViewCell",
                  bundle: nil),
            forCellReuseIdentifier: "CharacterShimmerTableViewCell")
        tableView.register(
            UINib(nibName: "CharacterTableViewCell",
                  bundle: nil),
            forCellReuseIdentifier: "CharacterTableViewCell")
    }
}

// MARK: - UITableView Delegate & DataSource
extension CharactersViewController: UITableViewDelegate,
                                    UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int)
    -> Int {
        if viewModel.isLoading, viewModel.isEmpty {
            return 20
        } else {
            return viewModel.characters.value.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        if viewModel.isLoading, viewModel.isEmpty {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "CharacterShimmerTableViewCell",
                for: indexPath) as? CharacterShimmerTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "CharacterTableViewCell",
                for: indexPath) as? CharacterTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(character: viewModel.characters.value[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if viewModel.isLoading, viewModel.isEmpty {
            guard let cell = cell as? CharacterShimmerTableViewCell else {
                return
            }
            // On Will Display Cell layout Cell if need
            // Cause changing of cell bounds
            cell.layoutIfNeeded()
            cell.animate()
            return
        }
    }
    
    // Did Select Character
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if viewModel.isLoading, viewModel.isEmpty {
            return
        }
        viewModel.didSelectItem(indexPath: indexPath)
    }
}
