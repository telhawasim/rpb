//
//  TagsTableViewCell.swift
//  RPB
//
//  Created by Bilal Nisar on 02/01/2023.
//

import UIKit

class TagsTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var tagsTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    //MARK: Variables
    var tagsArray: [String] = []
    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
      //  self.registerCell()
        self.tagsTextView.addPadding(size: 10)
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        guard let tag = tagsTextView.text else { return }
        tagsArray.append(tag)
        tagsTextView.text = nil
        collectionView.reloadData()
    }
    
//    func removeTags(index: Int) {
//        self.tagsArray.remove(at: index)
//        self.collectionView.reloadData()
//    }
    
//    func registerCell() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(TagsCollectionViewCell.className)
//    }
}

//extension TagsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        tagsArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.className, for: indexPath) as! TagsCollectionViewCell
//        cell.lblTagsName.text = tagsArray[indexPath.row]
//
//        cell.addTags = { [weak self] in
//            guard let self = self else {return}
//            if self.tagsArray.count > 0 {
//                self.removeTags(index: indexPath.row)
//            }
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        if collectionView.numberOfItems(inSection: section) == 1 {
//            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//            return UIEdgeInsets(top: 0, left: -20, bottom: 0, right: collectionView.frame.width - flowLayout.itemSize.width)
//        }
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//}
