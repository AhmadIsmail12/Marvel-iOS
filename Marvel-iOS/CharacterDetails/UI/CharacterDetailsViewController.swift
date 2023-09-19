//
//  CharacterDetailsViewController.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    private var viewModel: CharacterDetailsViewModel!
    
    // MARK: - Init
    static func create(with viewModel: CharacterDetailsViewModel)
    -> CharacterDetailsViewController {
        let view = CharacterDetailsViewController.loadFromNib()
        view.viewModel = viewModel
        return view
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Binding
    private func bind(to viewModel: CharacterDetailsViewModel) {
        viewModel.dataSource.observe(on: self) { [weak self] _ in
            self?.updateItems()
        }
        
        viewModel.loading.observe(on: self) { [weak self]  in
            self?.updateLoading($0)
        }
    }
    
    private func updateLoading(_ loading: Bool) {
        if loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func updateItems() {
        tableView.reloadData()
    }
    
    // MARK: - Setup
    private func setupViewController() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CharacterHeaderTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "CharacterHeaderTableViewCell")
        
        tableView.register(UINib(nibName: "CharacterContentTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "CharacterContentTableViewCell")
    }
}

// MARK: - UITableView Delegate & DataSource
extension CharacterDetailsViewController: UITableViewDelegate,
                                          UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath)
    -> CGFloat {
        switch viewModel.dataSource.value[indexPath.row] {
        case .header:
            return UITableView.automaticDimension
        default:
            return 290
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int)
    -> Int {
        return viewModel.dataSource.value.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        switch viewModel.dataSource.value[indexPath.row] {
        case .header:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "CharacterHeaderTableViewCell",
                for: indexPath) as? CharacterHeaderTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(character: viewModel.character)
            return cell
        case .content(let title, let content):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "CharacterContentTableViewCell",
                for: indexPath) as? CharacterContentTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(title: title, content: content)
            return cell
        }
    }
    
    
}
