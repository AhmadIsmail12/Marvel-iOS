//
//  CharacterContentTableViewCell.swift
//  Marvel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import UIKit

class CharacterContentTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var content: [CharacterContent] = []
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CharacterContentCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "CharacterContentCollectionViewCell")
    }
    
    // MARK: - Setup
    func setupCell(title: String, content: [CharacterContent]) {
        self.titleLabel.text = title
        self.content = content
        collectionView.reloadData()
    }
}

extension CharacterContentTableViewCell: UICollectionViewDelegate,
                                         UICollectionViewDataSource,
                                         UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int)
    -> Int {
        return content.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CharacterContentCollectionViewCell",
            for: indexPath) as? CharacterContentCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(content: content[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath)
    -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.45, height: 220)
    }
    
}
