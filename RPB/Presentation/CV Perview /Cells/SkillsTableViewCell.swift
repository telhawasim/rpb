//
//  SkillsTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 29/12/2022.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var collectionVewLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionVewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    //MARK: Variables
   
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerCell()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.contentView.frame = self.bounds
        self.layoutIfNeeded()
        return self.tagsCollectionView.contentSize
    }
}

extension SkillsTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagsCollectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.className, for: indexPath) as! TagsCollectionViewCell
        cell.lblTagsName.text = tagsArray[indexPath.row]
        return cell
    }
}

extension SkillsTableViewCell {
    //MARK: Register Cell
    func registerCell() {
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        tagsCollectionView.register(TagsCollectionViewCell.className)
    }
}
